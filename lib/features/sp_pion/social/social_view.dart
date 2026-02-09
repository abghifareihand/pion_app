import 'package:flutter/material.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/social/social_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';

class SocialView extends StatelessWidget {
  const SocialView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SocialViewModel>(
      model: SocialViewModel(),
      onModelReady: (SocialViewModel model) => model.initModel(),
      onModelDispose: (SocialViewModel model) => model.disposeModel(),
      builder: (BuildContext context, SocialViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Program Sosial'),
          backgroundColor: AppColors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, SocialViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
  return ListView(children: []);
}
