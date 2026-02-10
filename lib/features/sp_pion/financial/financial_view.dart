import 'package:flutter/material.dart';
import 'package:pion_app/core/api/financial_api.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/financial/financial_detail/financial_detail_view.dart';
import 'package:pion_app/features/sp_pion/financial/financial_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/shared/custom_shimmer.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:pion_app/ui/utils/formatter.dart';
import 'package:provider/provider.dart';

class FinancialView extends StatelessWidget {
  const FinancialView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<FinancialViewModel>(
      model: FinancialViewModel(
        financialApi: Provider.of<FinancialApi>(context),
      ),
      onModelReady: (FinancialViewModel model) => model.initModel(),
      onModelDispose: (FinancialViewModel model) => model.disposeModel(),
      builder: (BuildContext context, FinancialViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Laporan Keuangan'),
          backgroundColor: AppColors.background,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, FinancialViewModel model) {
  return RefreshIndicator(
    onRefresh: () async {
      await model.fetchListFinancial();
    },
    child:
        model.isBusy
            ? ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: 3,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, __) => CardShimmer(),
            )
            : model.listFinancial.isEmpty
            ? Center(
              child: Text(
                'Belum ada laporan keuangan',
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
              itemCount: model.listFinancial.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final data = model.listFinancial[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinancialDetailView(id: data.id),
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
                          'Laporan Keuangan',
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

