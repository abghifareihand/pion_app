import 'package:flutter/material.dart';
import 'package:pion_app/core/api/information_api.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/information/information_detail/information_detail_view.dart';
import 'package:pion_app/features/information/information_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:pion_app/ui/utils/formatter.dart';
import 'package:provider/provider.dart';

class InformationView extends StatelessWidget {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<InformationViewModel>(
      model: InformationViewModel(
        informationApi: Provider.of<InformationApi>(context),
      ),
      onModelReady: (InformationViewModel model) => model.initModel(),
      onModelDispose: (InformationViewModel model) => model.disposeModel(),
      builder: (BuildContext context, InformationViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Information'),
          backgroundColor: AppColors.background,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, InformationViewModel model) {
  return RefreshIndicator(
    onRefresh: () async {
      await model.fetchListInformation();
    },
    child: ListView.separated(
      itemCount: model.listInformation.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8.0),
      itemBuilder: (context, index) {
        final data = model.listInformation[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationDetailView(id: data.id),
              ),
            );
          },
          child: Container(
            color: AppColors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi',
                  style: AppFonts.medium.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  data.title,
                  style: AppFonts.medium.copyWith(
                    color: AppColors.darkGrey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  Formatter.toDateTimeFull(data.createdAt),
                  style: AppFonts.medium.copyWith(
                    color: AppColors.darkGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
