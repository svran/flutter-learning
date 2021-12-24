import 'package:file_selector/file_selector.dart';
import 'package:svran_flutter_study/tb/properties.dart';

import '../../public_code.dart';

class PropertiesModel {
  String? _app_gui_label;
  String? _app_label;
  String? _app_is_forward_locked;
  String? _app_version_code;
  String? _app_version_name;
  String? _app_apk_name;
  String? _app_apk_codec;
  String? _app_apk_md5;
  String? _app_gui_icon;
  String? _app_is_system;
  String? _app_apk_location;
  XFile file;

  PropertiesModel(this.file, Properties properties) {
    _app_apk_location = properties["app_apk_location"];
    _app_is_system = properties["app_is_system"];
    _app_gui_icon = properties["app_gui_icon"]?.replaceAll("\\", "=");
    _app_apk_md5 = properties["app_apk_md5"];
    _app_apk_codec = properties["app_apk_codec"];
    _app_apk_name = properties["app_apk_name"];
    _app_version_name = properties["app_version_name"];
    _app_version_code = properties["app_version_code"];
    _app_is_forward_locked = properties["app_is_forward_locked"];
    _app_label = properties["app_label"]?.replaceAllMapped(RegExp("([\\w]+)|(\\\\u([\\w]{4}))"), (match) {
      if (match.group(0)?.startsWith("\\u") == true) {
        return String.fromCharCode(_hexToInt(match.group(0).toString().replaceAll("\\u", "")));
      }
      return match.group(0).toString();
    });
    _app_gui_label = properties["app_gui_label"]?.replaceAllMapped(RegExp("([\\w]+)|(\\\\u([\\w]{4}))"), (match) {
      if (match.group(0)?.startsWith("\\u") == true) {
        return String.fromCharCode(_hexToInt(match.group(0).toString().replaceAll("\\u", "")));
      }
      return match.group(0).toString();
    });
  }

  int _hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

  @override
  String toString() {
    return 'PropertiesModel{_app_gui_label: $_app_gui_label, _app_label: $_app_label, _app_is_forward_locked: $_app_is_forward_locked, _app_version_code: $_app_version_code, _app_version_name: $_app_version_name, _app_apk_name: $_app_apk_name, _app_apk_codec: $_app_apk_codec, _app_apk_md5: $_app_apk_md5, _app_gui_icon: $_app_gui_icon, _app_is_system: $_app_is_system, _app_apk_location: $_app_apk_location}';
  }

  String? get app_gui_label => _app_gui_label;

  String? get app_label => _app_label;

  String? get app_is_forward_locked => _app_is_forward_locked;

  String? get app_version_code => _app_version_code;

  String? get app_version_name => _app_version_name;

  String? get app_apk_name => _app_apk_name;

  String? get app_apk_codec => _app_apk_codec;

  String? get app_apk_md5 => _app_apk_md5;

  String? get app_gui_icon => _app_gui_icon;

  String? get app_is_system => _app_is_system;

  String? get app_apk_location => _app_apk_location;
}
