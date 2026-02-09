import 'package:flutter/material.dart';
import 'package:pion_app/ui/shared/custom_appbar.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPreviewPage extends StatelessWidget {
  final String pdfUrl;

  const PdfPreviewPage({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'Preview PDF'),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
