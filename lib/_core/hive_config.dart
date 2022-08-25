import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../modules/user/data/models/hive/register_adapter.dart';

class HiveConfig {
  static init() async {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else if (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) {
      Directory directory =
          await path_provider.getApplicationDocumentsDirectory();
      await Hive.initFlutter("${directory.path}\\CloudWork\\Freelancer");
    } else {
      await Hive.initFlutter();
    }

    UserAdapter.registerUserAdapter();

    return Hive;
  }
}
