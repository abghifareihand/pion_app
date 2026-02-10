import 'package:flutter/material.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerName(width: 120, height: 14, isLoading: true),
          const SizedBox(height: 8),
          ShimmerName(width: 250, height: 12, isLoading: true),
          const SizedBox(height: 6),
          ShimmerName(width: 100, height: 10, isLoading: true),
        ],
      ),
    );
  }
}

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({super.key, this.height = 280});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Shimmer untuk image
              Container(
                height: height - 80, // sisakan untuk text bawah
                color: Colors.white,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(color: Colors.white),
                ),
              ),
              // Shimmer untuk text title & date
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerName(
                      width: double.infinity,
                      height: 14,
                      isLoading: true,
                    ),
                    SizedBox(height: 4),
                    ShimmerName(width: 80, height: 12, isLoading: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerName extends StatelessWidget {
  final double width;
  final double height;
  final bool isLoading;
  final String? text;
  final TextStyle? style;

  const ShimmerName({
    super.key,
    required this.width,
    required this.height,
    required this.isLoading,
    this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(width: width, height: height, color: Colors.white),
      );
    } else {
      return Text(text ?? '', style: style);
    }
  }
}
