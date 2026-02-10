import 'package:flutter/material.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/learning/learning_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';

class LearningView extends StatelessWidget {
  const LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LearningViewModel>(
      model: LearningViewModel(),
      onModelReady: (LearningViewModel model) => model.initModel(),
      onModelDispose: (LearningViewModel model) => model.disposeModel(),
      builder: (BuildContext context, LearningViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Materi Belajar'),
          backgroundColor: AppColors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, LearningViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
  return ListView(children: []);
}
