import 'package:photo_organizer/photo_organizer.dart' as photo_organizer;

void main(List<String> arguments) {
  print('photo_organizer - Automatically organize your photo library');
  if (arguments.length < 2) {
    print("""
    
NAME
    photo_organizer - Organize and copy photos from a source directory to a destination directory

SYNOPSIS
    photo_organizer source_path dest_path overwrite

DESCRIPTION
    The photo_organizer application recursively copies photos from the source directory to the destination directory while organizing them into a folder structure based on their creation date. Each photo will be renamed in the format yyyyMMdd_HHmmss.jpg (e.g., 20230923_105534.jpg).

PARAMETERS
    source_path:
        Path to the original photos folder, which will be traversed recursively to find photos.

    dest_path:
        Path to the destination folder where photos will be copied and organized.

    overwrite:
        If set to 'true', files with the same name and size in the destination folder will be overwritten. When a file with the same name but a different size is encountered in the destination folder, a progressive identifier will be added to the file name.

EXAMPLE
    photo_organizer /mnt/media/card /home/user/photos true

    This command will organize and copy photos from the "/mnt/media/card" source directory to the "/home/user/photos" destination directory. If a file with the same name and size exists in the destination directory, it will be overwritten if 'overwrite' is set to 'true'.
    """);
    return;
  }
  final String path = arguments[0]; //"/Volumes/photos/Foto/2022";
  final String destPath = arguments[1]; //"/Users/ste/Downloads";
  final bool overwrite = arguments.length > 2 && arguments[2] == 'true';
  photo_organizer.searchForPhotos(
      sourcePath: path, destPath: destPath, overwrite: overwrite);
}
