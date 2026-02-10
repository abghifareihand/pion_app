import 'package:flutter/material.dart';
import 'package:pion_app/core/api/information_api.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/information/information_detail/information_detail_view.dart';
import 'package:pion_app/features/information/information_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/shared/custom_shimmer.dart';
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
          appBar: CustomAppBar(title: 'Informasi'),
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
    child:
        model.isBusy
            ? ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, __) => CardShimmer(),
            )
            : model.listInformation.isEmpty
            ? Center(
              child: Text(
                'Belum ada informasi',
                style: AppFonts.medium.copyWith(
                  fontSize: 14,
                  color: AppColors.darkGrey,
                ),
              ),
            )
            : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.all(20),
              itemCount: model.listInformation.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final data = model.listInformation[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => InformationDetailView(id: data.id),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: AppColors.cardShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi',
                          style: AppFonts.medium.copyWith(
                            color: AppColors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          data.title,
                          style: AppFonts.medium.copyWith(
                            fontSize: 12,
                            color: AppColors.black.withValues(alpha: 0.5),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          Formatter.date.dateTime(data.createdAt),
                          style: AppFonts.medium.copyWith(
                            fontSize: 10,
                            color: AppColors.black.withValues(alpha: 0.5),
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