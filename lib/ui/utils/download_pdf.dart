import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pion_app/core/services/fcm_service.dart';

/// Download file PDF dari URL dan simpan ke folder Downloads
// Future<void> downloadPdf(String url, BuildContext context) async {
//   try {
//     final dio = Dio();

//     // Ambil nama file dari URL
//     final fileName = url.split('/').last;

//     // Dapatkan folder Downloads / Documents
//     Directory dir;
//     if (Platform.isAndroid) {
//       dir = (await getExternalStorageDirectory())!;
//     } else {
//       dir = await getApplicationDocumentsDirectory();
//     }

//     final filePath = '${dir.path}/$fileName';

//     // Download file
//     await dio.download(url, filePath);

//     // Tampilkan snackbar sukses
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('PDF berhasil diunduh: $fileName')));
//   } catch (e) {
//     debugPrint('Download failed: $e');
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('Download gagal')));
//   }
// }

// Future<void> downloadPdf(String url, BuildContext context) async {
//   try {
//     // --- Cek permission storage (Android 6+) ---
//     if (Platform.isAndroid) {
//       PermissionStatus status = await Permission.manageExternalStorage.request();
//       if (status.isGranted) {
//         log('Storage permission granted');
//       } else if (status.isDenied) {
//         log('Storage permission denied');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Permission storage ditolak')),
//         );
//         return;
//       } else if (status.isPermanentlyDenied) {
//         log('Storage permission permanently denied');
//         openAppSettings();
//         return;
//       }
//     }

//     final dio = Dio();

//     // Ambil nama file dari URL
//     final fileName = url.split('/').last;

//     // Dapatkan folder Downloads publik
//     Directory dir;
//     if (Platform.isAndroid) {
//       final dirs = await getExternalStorageDirectories(
//         type: StorageDirectory.downloads,
//       );
//       if (dirs == null || dirs.isEmpty) {
//         throw 'Folder Downloads tidak ditemukan';
//       }
//       dir = dirs.first;
//     } else {
//       dir = await getApplicationDocumentsDirectory();
//     }

//     final filePath = '${dir.path}/$fileName';

//     log('File akan disimpan di: $filePath');

//     // Download file
//     await dio.download(url, filePath);

//     // Tampilkan snackbar sukses
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('PDF berhasil diunduh: $fileName')));

//     log('Download selesai: $filePath');
//   } catch (e) {
//     debugPrint('Download failed: $e');
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('Download gagal')));
//   }
// }

// Download file PDF ke folder Downloads publik
Future<void> downloadPdf(String url, BuildContext context) async {
  try {
    final dio = Dio();

    // Ambil nama file dari URL
    final fileName = url.split('/').last;

    // --- Folder Downloads publik ---
    Directory dir;
    if (Platform.isAndroid) {
      dir = Directory('/storage/emulated/0/Download');
      if (!dir.existsSync()) dir.createSync(recursive: true);
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    final filePath = '${dir.path}/$fileName';
    log('Download path: $filePath');

    // Download file
    await dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          log('Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
        }
      },
    );

    // Snackbar sukses
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text('PDF berhasil diunduh: $fileName')));
  } catch (e) {
    debugPrint('Download failed: $e');
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(const SnackBar(content: Text('Download gagal')));
  }
}

Future<void> downloadPdfWithNotif(String url, String title) async {
  try {
    final dio = Dio();

    // Ambil nama file
    final fileName = url.split('/').last;

    // Folder Downloads publik
    Directory dir;
    if (Platform.isAndroid) {
      dir = Directory('/storage/emulated/0/Download');
      if (!dir.existsSync()) dir.createSync(recursive: true);
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    final filePath = '${dir.path}/$fileName';
    log('Download path: $filePath');

    // Download dengan progress
    await dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          final percent = (received / total * 100).toStringAsFixed(0);
          log('Downloading $fileName: $percent%');
        }
      },
    );

    // SnackBar sukses
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text('PDF berhasil diunduh: $fileName')));

    // ==== Notifikasi lokal ====
    final fcmService = FcmService();
    await fcmService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Download $title',
      body:
          'File berhasil di-download dan disimpan di sistem kamu. Cek di folder Downloads 👉',
    );
  } catch (e) {
    debugPrint('Download failed: $e');
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(const SnackBar(content: Text('Download gagal')));

    // Notif gagal
    final fcmService = FcmService();
    await fcmService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Download Gagal',
      body: url.split('/').last,
    );
  }
}
