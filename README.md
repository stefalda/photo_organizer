# photo_organizer

photo_organizer is a simple console application written in Dart that helps you organize and copy your photos from a source directory to a destination directory. It intelligently creates a folder structure based on the photos' creation date and allows you to specify whether to overwrite existing files in the destination folder.

## Features
- Recursively scan a source directory for photos.
- Organize photos into a folder structure: YEAR / MONTH / DAY.
- Rename photos with a timestamp format: yyyyMMdd_HHmmss.jpg (e.g., 20230923_105534.jpg).
- Option to overwrite existing files in the destination folder based on size.
- Automatically handle conflicts when files have the same name but different sizes.

## Installation
Before using photo_organizer, make sure you have Dart installed on your system.

1. Clone this repository to your local machine.
```bash
git clone https://github.com/stefalda/photo_organizer.git
```

2. Navigate to the project directory.
```bash
cd photo_organizer
```

3. Run the application using Dart.
```bash
dart photo_organizer.dart [source_path] [dest_path] [overwrite]
```
Replace `[source_path]`, `[dest_path]`, and `[overwrite]` with the appropriate values for your use case. Refer to the Usage section for more details.

If you want you can use the compiled version available in the Releases section.

## Usage
To use photo_organizer, provide at least two parameters:
- `source_path`: Path to the original photos folder (traversed in a recursive way).
- `dest_path`: Path to the destination folder.
- `overwrite`: If set to 'true', files with the same name and size in the destination folder will be overwritten. When a file with the same name but a different size is encountered in the destination folder, a progressive identifier will be added to the file name.

Example usage:
```bash
    photo_organizer /mnt/media/card /home/user/photos true
```
This command will organize and copy photos from the `/mnt/media/card` source directory to the `/home/user/photos` destination directory. Existing files may be overwritten based on the `overwrite` parameter.

## Releases
You can build yourself the application or download a release. Be sure to make the application executable by running in Linux or Macos:
```bash
chmod 755 photo_organizer
```

## License
This project is licensed under the MIT License.

## Contributing
Contributions are welcome! 

Feel free to open issues or pull requests if you have suggestions, bug reports, or feature requests.

## Acknowledgments
Special thanks to the Dart community for their support and inspiration.

Happy organizing your photos!