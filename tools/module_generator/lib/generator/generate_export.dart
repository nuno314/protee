// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:yaml/yaml.dart';

import '../common/file_helper.dart';

class ExportFile {
  final String fileName;
  final String folder;

  ExportFile({
    required this.fileName,
    required this.folder,
  });

  factory ExportFile.fromMap(Map<dynamic, dynamic> map) {
    return ExportFile(
      fileName: map['file_name'] as String,
      folder: map['folder'] as String,
    );
  }

  @override
  String toString() => 'ExportFile(fileName: $fileName, folder: $folder)';

  String get filePath => '$folder$fileName';
}

Future<void> generateExport({
  required List<YamlMap> config,
}) async {
  final exportConfigs = config.map((e) => ExportFile.fromMap(e.value));

  for (final c in exportConfigs) {
    final contents = [
      ...(await getFilesFromDirector(c.folder))
          .map((e) => e.replaceFirst(c.folder, ''))
    ]..sort();

    contents.add('');
    await FilesHelper.writeFile(
      pathFile: c.filePath,
      content: contents.join('\n'),
    );
  }
}

Future<List<String>> getFilesFromDirector(String directory) async {
  final contents = <String>[];
  final dir = Directory(directory);

  final entities = await dir.list().toList();
  for (final f in entities.whereType<File>()) {
    final fileContent = f.readAsStringSync();
    if (!fileContent.contains('part of \'')) {
      contents.add('export \'${f.path}\';');
    }
  }
  for (final f in entities.whereType<Directory>()) {
    contents.addAll(await getFilesFromDirector(f.path));
  }

  return contents;
}
