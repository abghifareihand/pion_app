import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:pion_app/ui/utils/formatter.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<String> images;
  final List<String> titles;
  final List<String> dates;

  const CustomCarouselSlider({
    super.key,
    required this.images,
    required this.titles,
    required this.dates,
  });

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items:
              widget.images.asMap().entries.map((entry) {
                final index = entry.key;
                final path = entry.value;
                final title = widget.titles[index];
                final date = widget.dates[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppColors.cardShadow,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child:
                                (path.isNotEmpty)
                                    ? ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        path,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder: (_, __, ___) {
                                          // kalau gagal load network, fallback
                                          return Container(
                                            color: AppColors.gray,
                                            alignment: Alignment.center,
                                            child: Assets.svg.iconPicture.svg(
                                              width: 50,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                    AppColors.primary,
                                                    BlendMode.srcIn,
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                    : Container(
                                      color: AppColors.white,
                                      alignment: Alignment.center,
                                      child: Assets.svg.iconPicture.svg(
                                        width: 50,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.primary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                          ),

                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: AppFonts.semiBold.copyWith(
                                    fontSize: 14,
                                    color: AppColors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  Formatter.date.dateTime(date),
                                  style: AppFonts.regular.copyWith(
                                    fontSize: 12,
                                    color: AppColors.black.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
          options: CarouselOptions(
            height: 280,
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              widget.images.asMap().entries.map((entry) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: _currentIndex == entry.key ? 12 : 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color:
                        _currentIndex == entry.key
                            ? AppColors.primary
                            : AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(4), // rounded rectangle
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
