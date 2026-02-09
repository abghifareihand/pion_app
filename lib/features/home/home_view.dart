import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pion_app/core/api/auth_api.dart';
import 'package:pion_app/core/api/information_api.dart';
import 'package:pion_app/core/api/vision_api.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/home/home_view_model.dart';
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
          backgroundColor: AppColors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, HomeViewModel model) {
  return ListView(
    children: [
      // Header
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            // Name email
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.profile?.name ?? '',
                    style: AppFonts.bold.copyWith(
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    model.profile?.email ?? '',
                    style: AppFonts.regular.copyWith(
                      color: AppColors.primary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            // Icon profile
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileView()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Assets.svg.iconUser.svg(
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 32.0),

      // Menu Card
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        crossAxisCount: 2,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
        children: [
          menuButton(
            iconPath: Assets.svg.iconSpPion.path,
            iconColor: const Color(0XFF3C4ABC),
            bgColor: const Color(0XFFD7DAF1),
            title: 'SP PION',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SpPionView()),
              );
            },
          ),
          menuButton(
            iconPath: Assets.svg.iconJoinPion.path,
            iconColor: const Color(0XFF22B07D),
            bgColor: const Color(0XFFD3EFE5),
            title: 'JOIN PION',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => JoinPionView()),
              );
            },
          ),
        ],
      ),

      const SizedBox(height: 32),

      // Vision, Informasi, dl
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visi',
              style: AppFonts.medium.copyWith(
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
            Formatter.html.render(
              model.vision?.title,
              textStyle: AppFonts.regular.copyWith(
                fontSize: 14,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Misi',
              style: AppFonts.medium.copyWith(
                color: AppColors.black,
                fontSize: 16,
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

      const SizedBox(height: 32.0),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Informasi Terkini',
              style: AppFonts.medium.copyWith(
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InformationView()),
                );
              },
              child: Text(
                'Lihat semua',
                style: AppFonts.regular.copyWith(
                  color: AppColors.darkGrey,
                  fontSize: 10,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 12.0),

      // Information Card
      ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 32),
        itemCount: model.listInformation.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12.0),
        itemBuilder: (context, index) {
          final data = model.listInformation[index];
          return informationCard(
            title: data.title,
            date: data.createdAt,
            onPressed: () {},
          );
        },
      ),
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
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color(0XFFE7EAED)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: bgColor ?? AppColors.primary,
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
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget informationCard({
  required String title,
  required String date,
  required VoidCallback onPressed,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0XFFE7EAED)),
      ),
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
            title,
            style: AppFonts.medium.copyWith(
              color: AppColors.darkGrey,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            Formatter.date.dateTimeFull(date),
            style: AppFonts.medium.copyWith(
              color: AppColors.gray,
              fontSize: 10,
            ),
          ),
        ],
      ),
    ),
  );
}
