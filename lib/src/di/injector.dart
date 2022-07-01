import 'package:get_it/get_it.dart';
import 'package:y_listener/src/data/models/provider/api_provider.dart';
import 'package:y_listener/src/data/models/provider/seacher_provider.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton(() => SearcherProvider());
  getIt.registerLazySingleton(() => APIProvider());
}
