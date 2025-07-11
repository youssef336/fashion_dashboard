import 'package:fashion_dashboard/core/services/firebase_auth_service.dart';
import 'package:fashion_dashboard/core/services/main/auth_service.dart';
import 'package:fashion_dashboard/core/services/main/storage_service.dart';
import 'package:fashion_dashboard/core/services/supabase_storage.dart';
import 'package:fashion_dashboard/features/auth/data/repo/auth_repo_impl.dart';
import 'package:fashion_dashboard/features/auth/domain/repo/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<AuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthService>()),
  );
  getIt.registerLazySingleton<StorageService>(() => SupabaseStorage());
}
