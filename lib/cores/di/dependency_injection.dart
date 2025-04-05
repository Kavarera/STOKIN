import 'package:get_it/get_it.dart';
import 'package:stokin_bloc/features/stokin/data/datasources/stokin_local_data_source.dart';
import 'package:stokin_bloc/features/stokin/data/repositories/product_repository_impl.dart';
import 'package:stokin_bloc/features/stokin/data/repositories/transaction_repository_impl.dart';
import 'package:stokin_bloc/features/stokin/domain/repositories/product_repository.dart';
import 'package:stokin_bloc/features/stokin/domain/repositories/transaction_repository.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/fab_cubit.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/home_bloc.dart';

import '../../features/stokin/data/repositories/category_repository_impl.dart';
import '../../features/stokin/domain/repositories/category_repository.dart';
import '../../features/stokin/domain/usecases/category_usecase.dart';
import '../../features/stokin/domain/usecases/product_usecase.dart';
import '../../features/stokin/domain/usecases/transaction_usecase.dart';
import '../../features/stokin/presentation/bloc/report/report_bloc.dart';

final DependencyInjection = GetIt.instance;
Future<void> init() async {
  //REGISTER ALL DEPENDENCIES..

  // SQFLITE
  DependencyInjection.registerLazySingleton(() => StokinLocalDataSource());

  // REPOSITORY
  //Product
  DependencyInjection.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(localDataSource: DependencyInjection()),
  );
  //Category
  DependencyInjection.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(localDataSource: DependencyInjection()),
  );
  //Transaction
  DependencyInjection.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(localDataSource: DependencyInjection()),
  );

  // USECASES
  //Product
  DependencyInjection.registerLazySingleton(
    () => InsertProductUseCase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => GetProductsUseCase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => UpdateProductUseCase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => DeleteProductUseCase(DependencyInjection()),
  );

  //Category
  DependencyInjection.registerLazySingleton(
    () => InsertCategoryUseCase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => GetCategoriesUseCase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => DeleteCategoryUseCase(DependencyInjection()),
  );

  //Transaction
  DependencyInjection.registerLazySingleton(
    () => InsertTransactionUseCase(DependencyInjection()),
  );

  DependencyInjection.registerLazySingleton(
    () => GetTransactionsUseCase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => DeleteTransactionUseCase(DependencyInjection()),
  );

  //CUBIT
  DependencyInjection.registerFactory(() => FabCubit());

  //BLoC
  // PAGE REPORT
  DependencyInjection.registerFactory(
    () => ReportBloc(
      const ReportState(),
      getCategoriesUseCase: DependencyInjection(),
      getTransactionsUseCase: DependencyInjection(),
    ),
  );

  // PAGE HOME
  DependencyInjection.registerFactory(
    () => HomeBloc(
      insertCategoryUseCase: DependencyInjection(),
      deleteCategoryUseCase: DependencyInjection(),
      getCategoriesUseCase: DependencyInjection(),
      insertProductUseCase: DependencyInjection(),
      deleteProductUseCase: DependencyInjection(),
      getProductsUseCase: DependencyInjection(),
      updateProductUseCase: DependencyInjection(),
      insertTransactionUseCase: DependencyInjection(),
      deleteTransactionUseCase: DependencyInjection(),
      getTransactionsUseCase: DependencyInjection(),
    ),
  );
}
