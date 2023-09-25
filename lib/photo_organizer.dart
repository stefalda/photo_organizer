import 'dart:io';

import 'package:exif/exif.dart';

searchForPhotos(
    {required String sourcePath,
    required String destPath,
    overwrite = false}) async {
  final dir = Directory(sourcePath);
  final List contents = dir.listSync(recursive: true);
  for (var fileOrDir in contents) {
    if (fileOrDir is File) {
      final String? ext = fileOrDir.path.toLowerCase().split(".").lastOrNull;
      if (ext == "jpg" || ext == 'jpeg') {
        print("Photo: ${fileOrDir.path}");
        final file = File(fileOrDir.path);
        final date = await _extractCaptureDate(file);
        if (date != null) {
          // Copy file changing name...
          final String copyTo =
              "$destPath/${date.year}/${_format(date.month)}/${_format(date.day)}";
          await Directory(copyTo).create(recursive: true);
          final String? destFilePath = _checkIfFileExistsAndReturnTheNewName(
              finalPath: copyTo, file: file, date: date, overwrite: overwrite);
          // If filename is null copy should be skipped
          if (destFilePath != null) {
            print("Copying $destFilePath");
            file.copySync(destFilePath);
          }
        } else {
          throw ("Invalid date?");
        }
      }
    } else if (fileOrDir is Directory) {
      print("File: ${fileOrDir.path}");
    }
  }
}

/// Check if the file name exists and if overwrite is not set add a progressive
/// and return the final filename or null if the file should not be written
String? _checkIfFileExistsAndReturnTheNewName(
    {required String finalPath,
    required File file,
    required DateTime date,
    progressive = 0,
    overwrite = false}) {
  String destFilePath = "$finalPath/${_getFilenameFromDate(date, progressive)}";
  // Check if file exists in the same path
  final existingFile = File(destFilePath);
  if (existingFile.existsSync()) {
    if (existingFile.lengthSync() == file.lengthSync()) {
      print("Skipping copy of fileOrDir.path - Already present");
      if (overwrite) {
        return destFilePath;
      }
      return null;
    } else {
      // Change the name of the dest file
      return _checkIfFileExistsAndReturnTheNewName(
          finalPath: finalPath,
          file: file,
          date: date,
          progressive: progressive + 1);
    }
  }
  return destFilePath;
}

/// Get the file name
_getFilenameFromDate(DateTime date, int progressive) {
  String sProgressive = progressive == 0 ? "" : '_$progressive';
  return "${date.year}${_format(date.month)}${_format(date.day)}_${_format(date.hour)}${_format(date.minute)}${_format(date.second)}$sProgressive.jpg";
}

_format(int num) {
  String s = num.toString();
  return s.length < 2 ? s.padLeft(2, '0') : s;
}

Future<DateTime?> _extractCaptureDate(File file) async {
  try {
    final fileBytes = file.readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);
    if (data.isEmpty) {
      print("No EXIF in_formation found");
      return null;
    }
    //
    if (data.containsKey("EXIF DateTimeOriginal")) {
      // 2022:01:01 15:38:40
      final IfdTag original = data["EXIF DateTimeOriginal"]!;
      final parts = original.printable.split(' ');
      final String fixedDate = '${parts[0].replaceAll(':', '-')} ${parts[1]}';
      return DateTime.parse(fixedDate);
    }
    throw "Missing EXIF DateTimeOriginal";
    //for (final entry in data.entries) {
    //  print("${entry.key}: ${entry.value}");
    //}
  } catch (ex) {
    print(ex);
    throw ("ERROR - $ex");
  }
}
