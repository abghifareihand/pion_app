import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pion_app/core/api/feed_api.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/chat/chat_view.dart';
import 'package:pion_app/features/sp_pion/financial/financial_view.dart';
import 'package:pion_app/features/sp_pion/learning/learning_view.dart';
import 'package:pion_app/features/sp_pion/organization/organization_view.dart';
import 'package:pion_app/features/sp_pion/social/social_view.dart';
import 'package:pion_app/features/sp_pion/sp_pion_view_model.dart';
import 'package:pion_app/features/sp_pion/vote/vote_view.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/shared/custom_carousel_slider.dart';
import 'package:pion_app/ui/shared/custom_shimmer.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:pion_app/ui/utils/formatter.dart';
import 'package:provider/provider.dart';

class SpPionView extends StatelessWidget {
  const SpPionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SpPionViewModel>(
      model: SpPionViewModel(feedApi: Provider.of<FeedApi>(context)),
      onModelReady: (SpPionViewModel model) => model.initModel(),
      onModelDispose: (SpPionViewModel model) => model.disposeModel(),
      builder: (BuildContext context, SpPionViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'SP PION'),
          backgroundColor: AppColors.background,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, SpPionViewModel model) {
  final carouselItems =
      model.listFeed.length >= 5
          ? model.listFeed.sublist(0, 5)
          : model.listFeed;

  final listItems = model.listFeed.length > 5 ? model.listFeed.sublist(5) : [];

  return ListView(
    children: [
      GridView.count(
        padding: const EdgeInsets.all(20),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
        children: [
          menuButton(
            iconPath: Assets.svg.iconMoney.path,
            title: 'Laporan Keungan',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FinancialView()),
              );
            },
          ),
          menuButton(
            iconPath: Assets.svg.iconOrganization.path,
            title: 'Stuktur Organisasi',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => OrganizationView()),
              );
            },
          ),
          menuButton(
            iconPath: Assets.svg.iconLearn.path,
            title: 'Materi Belajar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LearningView()),
              );
            },
          ),
          menuButton(
            iconPath: Assets.svg.iconSocial.path,
            title: 'Program Sosial',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SocialView()),
              );
            },
          ),
          menuButton(
            iconPath: Assets.svg.iconVotes.path,
            title: 'Profil   Serikat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VoteView()),
              );
            },
          ),
          menuButton(
            iconPath: Assets.svg.iconChat.path,
            title: 'Perubahan Data',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatView()),
              );
            },
          ),
          menuButton(
            iconPath: Assets.svg.iconVotes.path,
            title: 'Pemilihan Umum',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VoteView()),
              );
            },
          ),
          menuButton(
            iconPath: Assets.svg.iconChat.path,
            title: 'Pesan Admin',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatView()),
              );
            },
          ),
          menuButton(
            iconPath: Assets.svg.iconChat.path,
            title: 'Lihat Kartu Anggota',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatView()),
              );
            },
          ),
        ],
      ),
      const SizedBox(height: 8.0),

      // Carousel last 5 item
      if (model.isBusy)
        const CarouselShimmer()
      else if (carouselItems.isEmpty)
        const Center(child: Text('Belum ada feed'))
      else
        CustomCarouselSlider(
          images: carouselItems.map((e) => e.imageUrl ?? '').toList(),
          titles: carouselItems.map((e) => e.title).toList(),
          dates: carouselItems.map((e) => e.createdAt).toList(),
        ),

      const SizedBox(height: 24.0),
      // ===== List Informasi =====
      // CARD INFORMASI
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Informasi Terkini',
                  style: AppFonts.semiBold.copyWith(
                    color: AppColors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ===== List Informasi =====
            listItems.isEmpty
                ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'Belum ada informasi',
                      style: AppFonts.medium.copyWith(
                        fontSize: 14,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                )
                : ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listItems.length,
                  separatorBuilder:
                      (_, __) => Divider(color: AppColors.gray, thickness: 0.5),
                  itemBuilder: (context, index) {
                    final data = listItems[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informasi',
                            style: AppFonts.medium.copyWith(
                              color: AppColors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            data.title,
                            style: AppFonts.medium.copyWith(
                              fontSize: 12,
                              color: AppColors.black.withValues(alpha: 0.5),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            Formatter.date.dateTime(data.createdAt),
                            style: AppFonts.medium.copyWith(
                              fontSize: 10,
                              color: AppColors.black.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          ],
        ),
      ),

      const SizedBox(height: 24.0),
    ],
  );
}

Widget menuButton({
  required String iconPath,
  required String title,
  required VoidCallback onPressed,
  Color? iconColor,
  Color? bgColor,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: bgColor ?? AppColors.secondary.withValues(alpha: 0.2),
            ),
            width: 48,
            height: 48,
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                iconColor ?? AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            style: AppFonts.medium.copyWith(
              color: AppColors.black,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
