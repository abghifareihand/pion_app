import 'package:flutter/material.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/join_pion/join_pion_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';

class JoinPionView extends StatelessWidget {
  const JoinPionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<JoinPionViewModel>(
      model: JoinPionViewModel(),
      onModelReady: (JoinPionViewModel model) => model.initModel(),
      onModelDispose: (JoinPionViewModel model) => model.disposeModel(),
      builder: (BuildContext context, JoinPionViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'JOIN PION',),
          backgroundColor: AppColors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, JoinPionViewModel model) {
  if (model.isBusy) {
    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
  }
  return ListView(children: []);
}
