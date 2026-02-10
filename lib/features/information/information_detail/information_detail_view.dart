import 'package:flutter/material.dart';
import 'package:pion_app/core/api/information_api.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/information/information_detail/information_detail_view_model.dart';
import 'package:pion_app/ui/shared/button_preview.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:pion_app/ui/utils/formatter.dart';
import 'package:pion_app/ui/utils/pdf_preview.dart';
import 'package:provider/provider.dart';

import '../../../core/assets/assets.gen.dart';

class InformationDetailView extends StatelessWidget {
  final int id;
  const InformationDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BaseView<InformationDetailViewModel>(
      model: InformationDetailViewModel(
        informationApi: Provider.of<InformationApi>(context),
        id: id,
      ),
      onModelReady: (InformationDetailViewModel model) => model.initModel(),
      onModelDispose:
          (InformationDetailViewModel model) => model.disposeModel(),
      builder: (BuildContext context, InformationDetailViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Detail Informasi'),
          backgroundColor: AppColors.background,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, InformationDetailViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
  return ListView(
    children: [
      // Image
      Container(
        height: 300,
        color: AppColors.white,
        alignment: Alignment.center,
        child: Assets.svg.iconPicture.svg(
          width: 100,
          colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
        ),
      ),
      const SizedBox(height: 8.0),

      // Detail
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.detailInformation?.title ?? '',
              style: AppFonts.semiBold.copyWith(
                color: AppColors.black,
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
            Text(
              Formatter.date.dateTime(model.detailInformation?.createdAt ?? ''),
              style: AppFonts.regular.copyWith(
                color: AppColors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              model.detailInformation?.description ?? '',
              style: AppFonts.regular.copyWith(
                color: AppColors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24.0),

      // Button
      Center(
        child: ButtonPreview(
          onTap: () {
            final fileUrl = model.detailInformation?.fileUrl;
            if (fileUrl != null && fileUrl.isNotEmpty) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PdfPreviewPage(pdfUrl: fileUrl),
                ),
              );
            }
          },
        ),
      ),
    ],
  );
}
