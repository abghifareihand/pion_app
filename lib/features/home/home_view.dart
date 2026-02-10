import 'package:flutter/material.dart';
import 'package:pion_app/core/api/auth_api.dart';
import 'package:pion_app/core/api/information_api.dart';
import 'package:pion_app/core/api/vision_api.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/home/home_view_model.dart';
import 'package:pion_app/features/home/widgets/icon_label.dart';
import 'package:pion_app/features/information/information_detail/information_detail_view.dart';
import 'package:pion_app/features/information/information_view.dart';
import 'package:pion_app/features/join_pion/join_pion_view.dart';
import 'package:pion_app/features/profile/profile_view.dart';
import 'package:pion_app/features/sp_pion/sp_pion_view.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:pion_app/ui/utils/formatter.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      model: HomeViewModel(
        authApi: Provider.of<AuthApi>(context),
        visionApi: Provider.of<VisionApi>(context),
        informationApi: Provider.of<InformationApi>(context),
      ),
      onModelReady: (HomeViewModel model) => model.initModel(),
      onModelDispose: (HomeViewModel model) => model.disposeModel(),
      builder: (BuildContext context, HomeViewModel model, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBackground(BuildContext context) {
  final height = MediaQuery.of(context).size.height;

  return Column(
    children: [
      Container(
        height: height * 0.12,
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      ),
      Expanded(child: Container(color: AppColors.background)),
    ],
  );
}

Widget _buildBody(BuildContext context, HomeViewModel model) {
  return Stack(
    children: [
      // Background layer
      _buildBackground(context),

      RefreshIndicator(
        onRefresh: () async {
          await model.fetchProfile();
          await model.fetchVision();
          await model.fetchListInformation();
        },
        child: ListView(
          children: [
            const SizedBox(height: 32.0),
            // CARD NAME
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppColors.cardShadow,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.profile?.name ?? '',
                          style: AppFonts.semiBold.copyWith(
                            color: AppColors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          model.profile?.email ?? '',
                          style: AppFonts.regular.copyWith(
                            color: AppColors.black.withValues(alpha: 0.5),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Icon Setting
                  Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProfileView()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.primaryGradient,
                        ),
                        child: const Icon(
                          Icons.settings,
                          size: 18,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28.0),

            // MENU SP PION DAN JOIN PION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GradientIconLabel(
                      label: 'SP PION',
                      iconPath: Assets.svg.iconSpPion.path,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SpPionView()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: GradientIconLabel(
                      label: 'JOIN PION',
                      iconPath: Assets.svg.iconJoinPion.path,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JoinPionView(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // CARD VISI MISI
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppColors.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visi & Misi',
                    style: AppFonts.semiBold.copyWith(
                      color: AppColors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Visi',
                    style: AppFonts.semiBold.copyWith(
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                  Formatter.html.render(
                    model.vision?.title,
                    textStyle: AppFonts.regular.copyWith(
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                  Divider(color: AppColors.gray),
                  Text(
                    'Misi',
                    style: AppFonts.semiBold.copyWith(
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                  Formatter.html.render(
                    model.vision?.subtitle,
                    textStyle: AppFonts.regular.copyWith(
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

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
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const InformationView(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          child: Text(
                            'Lihat semua',
                            style: AppFonts.semiBold.copyWith(
                              color: AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ===== List Informasi =====
                  model.listInformation.isEmpty
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
                        itemCount:
                            model.listInformation.length > 3
                                ? 3
                                : model.listInformation.length,
                        separatorBuilder:
                            (_, __) =>
                                Divider(color: AppColors.gray, thickness: 0.5),
                        itemBuilder: (context, index) {
                          final data = model.listInformation[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          InformationDetailView(id: data.id),
                                ),
                              );
                            },
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
                                    color: AppColors.black.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  Formatter.date.dateTime(data.createdAt),
                                  style: AppFonts.medium.copyWith(
                                    fontSize: 10,
                                    color: AppColors.black.withValues(
                                      alpha: 0.5,
                                    ),
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
          ],
        ),
      ),
    ],
  );
}
