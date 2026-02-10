import 'package:flutter/material.dart';
import 'package:pion_app/core/api/learning_api.dart';
import 'package:pion_app/features/base_view.dart';
import 'package:pion_app/features/sp_pion/learning/learning_detail/learning_detail_view.dart';
import 'package:pion_app/features/sp_pion/learning/learning_view_model.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/shared/custom_shimmer.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:pion_app/ui/utils/formatter.dart';
import 'package:provider/provider.dart';

class LearningView extends StatelessWidget {
  const LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LearningViewModel>(
      model: LearningViewModel(learningApi: Provider.of<LearningApi>(context)),
      onModelReady: (LearningViewModel model) => model.initModel(),
      onModelDispose: (LearningViewModel model) => model.disposeModel(),
      builder: (BuildContext context, LearningViewModel model, _) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Materi Belajar'),
          backgroundColor: AppColors.background,
          body: _buildBody(context, model),
        );
      },
    );
  }
}

Widget _buildBody(BuildContext context, LearningViewModel model) {
  return RefreshIndicator(
    onRefresh: () async {
      await model.fetchListLearning();
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
            : model.listLearning.isEmpty
            ? Center(
              child: Text(
                'Belum ada materi belajar',
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
              itemCount: model.listLearning.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final data = model.listLearning[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LearningDetailView(id: data.id),
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
                          'Materi Belajar',
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
