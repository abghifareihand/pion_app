import 'package:flutter/material.dart';
import 'package:pion_app/core/api/financial_api.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/financial/financial_detail/financial_detail_view_model.dart';
import 'package:pion_app/ui/shared/button_preview.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:pion_app/ui/utils/formatter.dart';
import 'package:pion_app/ui/utils/pdf_preview.dart';
import 'package:provider/provider.dart';

class FinancialDetailView extends StatelessWidget {
  final int id;
  const FinancialDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BaseView<FinancialDetailViewModel>(
      model: FinancialDetailViewModel(
        financialApi: Provider.of<FinancialApi>(context),
        id: id,
      ),
      onModelReady: (FinancialDetailViewModel model) => model.initModel(),
      onModelDispose: (FinancialDetailViewModel model) => model.disposeModel(),
      builder: (BuildContext context, FinancialDetailViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Detail Laporan Keuangan'),
          backgroundColor: AppColors.background,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, FinancialDetailViewModel model) {
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
              model.detailFinancial?.title ?? '',
              style: AppFonts.semiBold.copyWith(
                color: AppColors.black,
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
            Text(
              Formatter.date.dateTime(model.detailFinancial?.createdAt ?? ''),
              style: AppFonts.regular.copyWith(
                color: AppColors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              model.detailFinancial?.description ?? '',
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
            final fileUrl = model.detailFinancial?.fileUrl;
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
