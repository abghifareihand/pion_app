import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/chat/chat_view.dart';
import 'package:pion_app/features/sp_pion/financial/financial_view.dart';
import 'package:pion_app/features/sp_pion/learn/learn_view.dart';
import 'package:pion_app/features/sp_pion/organization/organization_view.dart';
import 'package:pion_app/features/sp_pion/social/social_view.dart';
import 'package:pion_app/features/sp_pion/sp_pion_view_model.dart';
import 'package:pion_app/features/sp_pion/vote/vote_view.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';

class SpPionView extends StatelessWidget {
  const SpPionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SpPionViewModel>(
      model: SpPionViewModel(),
      onModelReady: (SpPionViewModel model) => model.initModel(),
      onModelDispose: (SpPionViewModel model) => model.disposeModel(),
      builder: (BuildContext context, SpPionViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'SP PION'),
          backgroundColor: AppColors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, SpPionViewModel model) {
  return GridView.count(
    padding: const EdgeInsets.all(24),
    physics: const BouncingScrollPhysics(),
    crossAxisCount: 3,
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
    childAspectRatio: 0.9,
    children: [
      menuButton(
        iconPath: Assets.svg.iconMoney.path,
        title: 'Laporan Keungan',
        iconColor: const Color(0xFF22B07D),
        bgColor: const Color(0xFFD3EFE5),
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
        iconColor: const Color(0xFF3C4ABC),
        bgColor: const Color(0xFFD7DAF1),
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
        iconColor: const Color(0xFFFF8A00),
        bgColor: const Color(0xFFFFE6C7),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LearnView()),
          );
        },
      ),
      menuButton(
        iconPath: Assets.svg.iconSocial.path,
        title: 'Program Sosial',
        iconColor: const Color(0xFFDC3545),
        bgColor: const Color(0xFFFFD6D9),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SocialView()),
          );
        },
      ),
      menuButton(
        iconPath: Assets.svg.iconVotes.path,
        title: 'Pemilihan Umum',
        iconColor: const Color(0xFF6F42C1),
        bgColor: const Color(0xFFE8DBF7),
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
        iconColor: const Color(0xFF0D6EFD),
        bgColor: const Color(0xFFD6E4FF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatView()),
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
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
