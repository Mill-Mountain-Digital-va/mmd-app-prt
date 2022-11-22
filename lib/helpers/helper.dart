// import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';

import 'package:global_configuration/global_configuration.dart';
import '../elements/CircularLoadingWidget.dart';
// import 'package:html/dom.dart' as dom;

// import '../../generated/l10n.dart';
// import '../models/workout.dart';

// import '../providers/settings_repository.dart';
// import '../providers/user_repository.dart' as userRepo;
// import '../providers/settings_repository.dart' as settingsRepo;

import 'dart:async';

class Helper {
  BuildContext? context;
  Helper.of(BuildContext _context) {
    this.context = _context;
  }
  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {
    return data['result']['data'] ?? [];
  }

  static int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int);
  }

  static bool getBoolData(Map<String, dynamic> data) {
    return (data['data'] as bool);
  }

  static getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  static Uri getUri(String path) {
    String _path = Uri.parse(GlobalConfiguration().getValue('base_url')).path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        scheme: Uri.parse(GlobalConfiguration().getValue('base_url')).scheme,
        host: Uri.parse(GlobalConfiguration().getValue('base_url')).host,
        path: _path + path);
    return uri;
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Theme.of(context).disabledColor.withOpacity(0.5),
          child: CircularLoadingWidget(height: 200),
        ),
      );
    });
    return loader;
  }
  
}