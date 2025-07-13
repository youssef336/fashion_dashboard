import 'package:fashion_dashboard/core/repo/addProduct/add_product_repo.dart';
import 'package:fashion_dashboard/core/repo/addProduct/add_product_repo_impl.dart';
import 'package:fashion_dashboard/core/repo/add_image/add_image_repo.dart';
import 'package:fashion_dashboard/core/repo/add_image/add_image_repo_impl.dart';
import 'package:fashion_dashboard/core/repo/customer_pay/customer_pay_repo.dart';
import 'package:fashion_dashboard/core/repo/customer_pay/customer_pay_repo_impl.dart';
import 'package:fashion_dashboard/core/repo/fetchproduct/fetch_product_repo.dart';
import 'package:fashion_dashboard/core/repo/fetchproduct/fetch_product_repo_impl.dart';
import 'package:fashion_dashboard/core/services/firebase_auth_service.dart';
import 'package:fashion_dashboard/core/services/firebase_database_server.dart';
import 'package:fashion_dashboard/core/services/main/auth_service.dart';
import 'package:fashion_dashboard/core/services/main/database_service.dart';
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
  getIt.registerLazySingleton<DatabaseService>(() => FirebaseDatabaseServer());
  getIt.registerLazySingleton<AddProductRepo>(
    () => AddProductRepoImpl(getIt<DatabaseService>()),
  );
  getIt.registerLazySingleton<AddImageRepo>(
    () => AddImageRepoImpl(getIt<StorageService>()),
  );
  getIt.registerLazySingleton<FetchProductRepo>(
    () => FetchProductRepoImpl(databaseService: getIt<DatabaseService>()),
  );
  getIt.registerLazySingleton<CustomerPayRepo>(
    () => CustomerPayRepoImpl(getIt<DatabaseService>()),
  );
}
