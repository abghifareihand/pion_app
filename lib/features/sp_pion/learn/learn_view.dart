import 'package:flutter/material.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/learn/learn_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';

class LearnView extends StatelessWidget {
  const LearnView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LearnViewModel>(
      model: LearnViewModel(),
      onModelReady: (LearnViewModel model) => model.initModel(),
      onModelDispose: (LearnViewModel model) => model.disposeModel(),
      builder: (BuildContext context, LearnViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Materi Belajar'),
          backgroundColor: AppColors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, LearnViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
  return ListView(children: []);
}
