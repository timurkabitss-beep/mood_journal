import 'package:hive/hive.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';

class UserSettingsRepository {
  static const _boxName = "user_settings";

  Future<void> save(String name, String themeId) async{
    final box = await Hive.openBox<String>(_boxName);
    await box.put("name", name);
    await box.put("themeId", themeId);
  }

  Future<(String, String)> load() async{
    final box = await Hive.openBox<String>(_boxName);
    return (
    box.get("name") ?? "",
    box.get("themeId") ?? ""
    );
  }
}