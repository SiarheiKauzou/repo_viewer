import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';

class SembastDatabase {
  late Database _instance;

  Database get instance => _instance;

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    if (_hasBeenInitialized) return;
    final dbDirectory = await getApplicationDocumentsDirectory();
    dbDirectory.create(recursive: true);
    final dbPath = '${dbDirectory.path}/db.sembast';
    _instance = await databaseFactoryMemory.openDatabase(dbPath);
    _hasBeenInitialized = true;
  }
}
