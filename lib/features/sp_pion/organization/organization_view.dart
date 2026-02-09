import 'package:flutter/material.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/organization/organization_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';

class OrganizationView extends StatelessWidget {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OrganizationViewModel>(
      model: OrganizationViewModel(),
      onModelReady: (OrganizationViewModel model) => model.initModel(),
      onModelDispose: (OrganizationViewModel model) => model.disposeModel(),
      builder: (BuildContext context, OrganizationViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Struktur Organisasi'),
          backgroundColor: AppColors.white,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, OrganizationViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
  return ListView(children: []);
}
