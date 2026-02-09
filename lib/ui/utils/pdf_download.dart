import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pion_app/core/services/fcm_service.dart';

Future<void> pdfDownloadNotification(String url, String title) async {
  try {
    final dio = Dio();

    final fileName = url.split('/').last;

    // Download file sebagai bytes
    final response = await dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (received, total) {
        if (total != -1) {
          final percent = (received / total * 100).toStringAsFixed(0);
          log('Downloading $fileName: $percent%');
        }
      },
    );

    final bytes = Uint8List.fromList(response.data!);

    // ===== Simpan ke folder Downloads publik =====
    Directory dir;
    if (Platform.isAndroid) {
      dir = Directory('/storage/emulated/0/Download');
      if (!dir.existsSync()) dir.createSync(recursive: true);
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    // Setelah download file sukses
    final filePath = '${dir.path}/$fileName';
    await File(filePath).writeAsBytes(bytes, flush: true);

    log('File saved at: $filePath');

    // ===== Notifikasi sukses =====
    final fcmService = FcmService();
    await fcmService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Download $title',
      body: 'File berhasil di-download. Cek di folder Downloads 📄',
      payload: filePath,
    );
  } catch (e) {
    debugPrint('Download failed: $e');

    // ===== Notifikasi gagal =====
    final fcmService = FcmService();
    await fcmService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Download Gagal',
      body: 'Gagal mengunduh file PDF',
    );
  }
}
