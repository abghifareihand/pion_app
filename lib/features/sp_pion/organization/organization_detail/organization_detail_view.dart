import 'package:flutter/material.dart';
import 'package:pion_app/core/api/organization_api.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/organization/organization_detail/organization_detail_view_model.dart';
import 'package:pion_app/ui/shared/button_preview.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:pion_app/ui/utils/formatter.dart';
import 'package:pion_app/ui/utils/pdf_preview.dart';
import 'package:provider/provider.dart';

class OrganizationDetailView extends StatelessWidget {
  final int id;
  const OrganizationDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BaseView<OrganizationDetailViewModel>(
      model: OrganizationDetailViewModel(
        organizationApi: Provider.of<OrganizationApi>(context),
        id: id,
      ),
      onModelReady: (OrganizationDetailViewModel model) => model.initModel(),
      onModelDispose: (OrganizationDetailViewModel model) => model.disposeModel(),
      builder: (BuildContext context, OrganizationDetailViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Detail Struktur Organisasi'),
          backgroundColor: AppColors.background,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, OrganizationDetailViewModel model) {
  if (model.isBusy) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
  final imageUrl = model.detailOrganization?.imageUrl;
  return ListView(
    children: [
      // Image / fallback icon
      Container(
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: AppColors.cardShadow,
        ),
        alignment: Alignment.center,
        child:
            (imageUrl != null)
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) {
                      // kalau gagal load network
                      return Assets.svg.iconPicture.svg(
                        width: 100,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      );
                    },
                  ),
                )
                : Assets.svg.iconPicture.svg(
                  width: 100,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
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
              model.detailOrganization?.title ?? '',
              style: AppFonts.semiBold.copyWith(
                color: AppColors.black,
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
            Text(
              Formatter.date.dateTime(model.detailOrganization?.createdAt ?? ''),
              style: AppFonts.regular.copyWith(
                color: AppColors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              model.detailOrganization?.description ?? '',
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
            final fileUrl = model.detailOrganization?.fileUrl;
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
