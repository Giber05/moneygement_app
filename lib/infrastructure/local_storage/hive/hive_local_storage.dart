import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class HiveLocalStorage {
  Future<void> saveData<T>(String key, T data);
  Future<T> readData<T>(String key);
  Future<void> deleteData(String key);
}
@Injectable(as:HiveLocalStorage)
class HiveLocalStorageImpl implements HiveLocalStorage {

  HiveLocalStorageImpl();

  Box<dynamic> _getOpenBox() {
    return Hive.box<dynamic>('quizBox');
  }

  @override
  Future<void> saveData<T>(String key,T data) async {
    var box = _getOpenBox();
    await box.put(key, data);
  }

  @override
  Future<T> readData<T>(String key) async {
    var box = _getOpenBox();
    return box.get(key);
  }

  @override
  Future<void> deleteData(String key) async {
    var box = _getOpenBox();
    await box.delete(key);
  }
}