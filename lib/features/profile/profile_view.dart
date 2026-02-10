import 'package:flutter/material.dart';
import 'package:pion_app/core/api/auth_api.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/core/models/profile_model.dart';
import 'package:pion_app/features/auth/login/login_view.dart';
import 'package:pion_app/features/profile/edit-profile/edit_profile_view.dart';
import 'package:pion_app/features/profile/profile_view_model.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/shared/custom_button.dart';
import 'package:pion_app/ui/shared/custom_snackbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      model: ProfileViewModel(authApi: Provider.of<AuthApi>(context)),
      onModelReady: (model) => model.initModel(),
      onModelDispose: (ProfileViewModel model) => model.disposeModel(),
      builder: (BuildContext context, ProfileViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Profile'),
          backgroundColor: AppColors.background,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, ProfileViewModel model) {
  return ListView(
    padding: EdgeInsets.all(24),
    children: [
      ProfileHeader(isLoading: model.isBusy, profile: model.profile),
      const SizedBox(height: 32.0),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Akun',
              style: AppFonts.regular.copyWith(
                color: AppColors.black.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8.0),
            profileMenu(
              icon: Icons.person,
              title: 'Informasi Akun',
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => EditProfileView(profile: model.profile!),
                  ),
                );
                if (result == true) {
                  await model.fetchProfile();
                }
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 24.0),
      Button.filled(
        onPressed: () async {
          await model.logout();
          if (context.mounted) {
            if (model.error) {
              CustomSnackbar.showError(context, model.message);
            }
            if (model.success) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
                (route) => false,
              );
            }
          }
        },
        label: 'Logout',
        color: Colors.red,
        isLoading: model.isBusy,
      ),
    ],
  );
}

Widget profileMenu({
  required IconData icon,
  required String title,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.secondary.withValues(alpha: 0.2),
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 12.0),
        Text(
          title,
          style: AppFonts.medium.copyWith(color: AppColors.black, fontSize: 14),
        ),
        const Spacer(),
        const Icon(Icons.chevron_right, color: AppColors.black),
      ],
    ),
  );
}

class ProfileHeader extends StatelessWidget {
  final bool isLoading;
  final ProfileData? profile;

  const ProfileHeader({super.key, required this.isLoading, this.profile});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildShimmer();
    }
    return _buildContent();
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svg.iconPerson2.svg(width: 120, height: 120),
          const SizedBox(height: 8.0),
          Text(
            profile?.name ?? '',
            style: AppFonts.medium.copyWith(
              color: AppColors.black,
              fontSize: 14,
            ),
          ),
          Text(
            profile?.email ?? '',
            style: AppFonts.medium.copyWith(
              color: AppColors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(width: 140, height: 16, color: Colors.white),
            const SizedBox(height: 6),
            Container(width: 80, height: 14, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
