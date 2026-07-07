import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../model/profile.dart';
import '../model/food_allergy.dart';

class IsarDatabaseService {
  static final IsarDatabaseService _instance = IsarDatabaseService._internal();
  late Future<Isar> _isarFuture;

  factory IsarDatabaseService() {
    return _instance;
  }

  IsarDatabaseService._internal() {
    _isarFuture = _initIsar();
  }

  Future<Isar> get isar => _isarFuture;

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [ProfileSchema, FoodAllergySchema],
      directory: dir.path,
    );
  }
}