import 'dart:async';
import 'dart:io';

import '../common/common_function.dart';
import '../common/definations.dart';
import '../common/file_helper.dart';
import '../res/templates/asset/assets.dart';
import '../res/templates/asset/image_assets.dart';
import '../res/templates/asset/other_assets.dart';
import '../res/templates/asset/svg_assets.dart';

class AssetFile {
  final String variableName;
  final String filePath;

  AssetFile({required this.variableName, required this.filePath});
}

Future<void> generateAsset({
  required List<String> paths,
  required String output,
  String? root,
}) async {
  await FilesHelper.createFolder(output);
  final listAssets = <AssetFile>[];
  for (final p in paths) {
    final dir = Directory(p);

    final entities = await dir.list().toList();
    for (final f in entities.whereType<File>()) {
      final fileName = f.path.split('/').last.split('.').first;

      listAssets.add(AssetFile(
        variableName: camelCase(fileName),
        filePath: f.path,
      ));
    }
  }
  listAssets.sort((a, b) => a.variableName.compareTo(b.variableName));
  var svgContentFile = '';
  var imageContentFile = '';
  var otherContentFile = '';
  for (final a in listAssets) {
    var append = '';

    append += root != null ? '\n\n  // [$root/${a.filePath}]' : '';
    final line = '  final String ${a.variableName} = \'${a.filePath}\';';
    if (line.length > 80) {
      append += '''\n  final String ${a.variableName} =
      '${a.filePath}';''';
    } else {
      append += '\n$line';
    }
    if (['.png', '.jpg', '.jpeg'].any((ext) => a.filePath.contains(ext))) {
      imageContentFile += append;
    } else if (['.svg'].any((ext) => a.filePath.contains(ext))) {
      svgContentFile += append;
    } else {
      otherContentFile += append;
    }
  }
  await FilesHelper.writeFile(
    pathFile: '${output}assets.dart',
    content: assetsRes,
  );

  await FilesHelper.writeFile(
    pathFile: '${output}image_assets.dart',
    content: imageAssetsRes.replaceFirst(contentKey, imageContentFile),
  );

  await FilesHelper.writeFile(
    pathFile: '${output}svg_assets.dart',
    content: svgAssetsRes.replaceFirst(contentKey, svgContentFile),
  );

  await FilesHelper.writeFile(
    pathFile: '${output}other_assets.dart',
    content: otherAssetsRes.replaceFirst(contentKey, otherContentFile),
  );
}

Future<void> removeUnusedAssets({
  required List<String> resPaths,
  required String output,
  String? root,
}) async {
  final listAssets = <AssetFile>[];
  for (final p in resPaths) {
    final dir = Directory(p);

    final entities = await dir.list().toList();
    for (final f in entities.whereType<File>()) {
      final fileName = f.path.split('/').last.split('.').first;

      listAssets.add(AssetFile(
        variableName: camelCase(fileName),
        filePath: f.path,
      ));
    }
  }
  listAssets.sort((a, b) => a.variableName.compareTo(b.variableName));
  var svgAssetFile = <AssetFile>[];
  var imageAssetFile = <AssetFile>[];
  var otherAssetFile = <AssetFile>[];
  for (final a in listAssets) {
    final variable = a.variableName;
    if (['.png', '.jpg', '.jpeg'].any((ext) => a.filePath.contains(ext))) {
      imageAssetFile.add(AssetFile(
        variableName: 'Assets.image.$variable',
        filePath: a.filePath,
      ));
    } else if (['.svg'].any((ext) => a.filePath.contains(ext))) {
      svgAssetFile.add(AssetFile(
        variableName: 'Assets.svg.$variable',
        filePath: a.filePath,
      ));
    } else {
      otherAssetFile.add(AssetFile(
        variableName: 'Assets.other.$variable',
        filePath: a.filePath,
      ));
    }
  }

  final allDartFiles = await _getAllDartFilePathsInDir('lib/');
  for (final f in allDartFiles) {
    final content = await f.readAsString();

    svgAssetFile.removeWhere((svg) => content.contains(svg.variableName));
    imageAssetFile.removeWhere((image) => content.contains(image.variableName));
    otherAssetFile.removeWhere((other) => content.contains(other.variableName));
  }
  for (final svg in svgAssetFile) {
    print('removed svg asset: ${svg.filePath}');
    await File(svg.filePath).delete();
  }
  for (final image in imageAssetFile) {
    final dir = ([...image.filePath.split('/')]..removeLast()).join('/') + '/';
    print('removed image asset: ${image.filePath}');
    await File(image.filePath).delete();

    await File(image.filePath).name.let((name) async {
      await File(dir + '2.0x/' + name).let((file) async {
        if (await file.exists()) {
          print('removed image asset: ${file.path}');
          await file.delete();
        }
      });

      await File(dir + '3.0x/' + name).let((file) async {
        if (await file.exists()) {
          print('removed image asset: ${file.path}');
          await file.delete();
        }
      });
    });
  }
  for (final other in otherAssetFile) {
    print('removed other asset: ${other.filePath}');
    await File(other.filePath).delete();
  }

  await generateAsset(
    paths: resPaths,
    output: output,
    root: root,
  );
}

Future<List<File>> _getAllDartFilePathsInDir(String dir) async {
  final paths = <File>[];
  final _dir = Directory(dir);

  final entities = await _dir.list().toList();
  for (final e in entities) {
    if (e is File && e.path.contains('.dart')) {
      paths.add(e);
    } else if (e is Directory) {
      paths.addAll(await _getAllDartFilePathsInDir(e.path));
    }
  }
  return paths;
}
