import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DownloadButton extends StatefulWidget {
  final String url;
  const DownloadButton({super.key, required this.url});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  final ValueNotifier<double> progress = ValueNotifier<double>(0);

  Future<void> download() async {
    try {
      final dio = Dio();
      final fileName = widget.url.split('/').last;
      final dir = Directory('/storage/emulated/0/Download');
      if (!dir.existsSync()) dir.createSync(recursive: true);
      final filePath = '${dir.path}/$fileName';

      await dio.download(widget.url, filePath, onReceiveProgress: (rec, total) {
        if (total != -1) {
          progress.value = rec / total; // Update progress 0..1
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF berhasil diunduh: $fileName')),
      );
    } catch (e) {
      debugPrint('Download failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Download gagal')),
      );
    } finally {
      progress.value = 0; // reset
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<double>(
          valueListenable: progress,
          builder: (context, value, _) {
            return LinearProgressIndicator(
              value: value == 0 ? null : value, // null = indeterminate
              minHeight: 6,
              color: Colors.blue,
              backgroundColor: Colors.grey.shade300,
            );
          },
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: download,
          child: const Text('Download PDF'),
        ),
      ],
    );
  }
}
