import 'package:get_it/get_it.dart';
import 'package:posapp_bloc/features/posapp_bloc/data/datasource/posapp_local_datasource.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/usecases/product_usecase.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/usecases/transaction_usecase.dart';
import 'package:posapp_bloc/features/posapp_bloc/presentation/bloc/transaction/transaction_bloc.dart';

import '../../features/posapp_bloc/data/repositories/product_repository_impl.dart';
import '../../features/posapp_bloc/data/repositories/transaction_repository_impl.dart';
import '../../features/posapp_bloc/domain/repositories/product_repository.dart';
import '../../features/posapp_bloc/domain/repositories/transaction_repository.dart';
import '../../features/posapp_bloc/presentation/bloc/home/fab_cubit.dart';
import '../../features/posapp_bloc/presentation/bloc/home/home_bloc.dart';
import '../../features/posapp_bloc/presentation/bloc/report/report_bloc.dart';

final DependencyInjection = GetIt.instance;
Future<void> init() async {
  //REGISTER ALL DEPENDENCIES..

  // SQFLITE
  DependencyInjection.registerLazySingleton(() => PosappLocalDatasource());

  // REPOSITORY
  //Product
  DependencyInjection.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(DependencyInjection()),
  );
  //Category
  //Transaction
  DependencyInjection.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(DependencyInjection()),
  );

  // USECASES
  //Product
  DependencyInjection.registerLazySingleton(
    () => InsertProductUsecase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => GetProductUsecase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => UpdateProductUsecase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => DeleteProductUsecase(DependencyInjection()),
  );

  //Transaction
  DependencyInjection.registerLazySingleton(
    () => InsertTransactionUseCase(DependencyInjection()),
  );

  DependencyInjection.registerLazySingleton(
    () => GetTransactionUseCase(DependencyInjection()),
  );
  DependencyInjection.registerLazySingleton(
    () => DeleteTransactionUseCase(DependencyInjection()),
  );

  DependencyInjection.registerLazySingleton(
    () => UpdateTransactionUseCase(DependencyInjection()),
  );

  //CUBIT
  DependencyInjection.registerFactory(() => FabCubit());

  //BLoC
  // PAGE REPORT
  // DependencyInjection.registerFactory(
  //   () => ReportBloc(
  //     const ReportState(),
  //     getCategoriesUseCase: DependencyInjection(),
  //     getTransactionsUseCase: DependencyInjection(),
  //   ),
  // );

  // PAGE HOME
  DependencyInjection.registerFactory(
    () => HomeBloc(
      DependencyInjection(),
      DependencyInjection(),
      DependencyInjection(),
      DependencyInjection(),
      DependencyInjection(),
      DependencyInjection(),
    ),
  );

  DependencyInjection.registerFactory(
    () => TransactionBloc(
      DependencyInjection(),
      DependencyInjection(),
      DependencyInjection(),
    ),
  );

  DependencyInjection.registerFactory(
    () => ReportBloc(getTransactionUseCase: DependencyInjection()),
  );
}
