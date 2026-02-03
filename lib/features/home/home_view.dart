import 'package:pion_app/core/services/notif_service.dart';
import 'package:provider/provider.dart';
import 'package:pion_app/core/api/auth_api.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/home/home_view_model.dart';
import 'package:pion_app/features/home/widgets/shimmer_name.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      model: HomeViewModel(authApi: Provider.of<AuthApi>(context)),
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
  return RefreshIndicator(
    onRefresh: () async {
      await model.fetchProfile();
    },
    child: ListView(
      children: [
        // Nama
        Container(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.svg.iconPerson.path,
                width: 34,
                height: 34,
              ),
              const SizedBox(width: 4.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerName(
                    width: 100,
                    height: 12,
                    isLoading: model.isBusy,
                    text: model.name,
                    style: AppFonts.medium.copyWith(
                      color: AppColors.black,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ShimmerName(
                    width: 150,
                    height: 10,
                    isLoading: model.isBusy,
                    text: model.email,
                    style: AppFonts.regular.copyWith(
                      color: AppColors.black,
                      fontSize: 10,
                      height: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32.0),
      ],
    ),
  );
}

Widget menuButton({
  required String iconPath,
  required String title,
  required String subtitle,
  required VoidCallback onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 30.0,
            spreadRadius: 0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            width: 48,
            height: 48,
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
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
          Text(
            subtitle,
            style: AppFonts.medium.copyWith(
              color: AppColors.gray,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
