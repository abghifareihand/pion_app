import 'package:flutter/material.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/vote/vote_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';

class VoteView extends StatelessWidget {
  const VoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<VoteViewModel>(
      model: VoteViewModel(),
      onModelReady: (VoteViewModel model) => model.initModel(),
      onModelDispose: (VoteViewModel model) => model.disposeModel(),
      builder: (BuildContext context, VoteViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Pemilihan Umum'),
          backgroundColor: AppColors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, VoteViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
  return ListView(children: []);
}
