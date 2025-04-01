import 'package:get/get.dart';
import 'package:stokin/features/stokin/data/datasources/stokin_local_data_source.dart';
import 'package:stokin/features/stokin/data/repositories/category_repository_impl.dart';
import 'package:stokin/features/stokin/data/repositories/product_repository_impl.dart';
import 'package:stokin/features/stokin/data/repositories/transaction_repository_impl.dart';
import 'package:stokin/features/stokin/domain/repositories/category_repository.dart';
import 'package:stokin/features/stokin/domain/repositories/product_repository.dart';
import 'package:stokin/features/stokin/domain/repositories/transaction_repository.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    //DATTASOURCE
    Get.lazyPut<StokinLocalDataSource>(
      () => StokinLocalDataSource(),
      fenix: true,
    );

    //REPOSITORY
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepositoryImpl(localDataSource: Get.find()),
      fenix: true,
    );
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(localDataSource: Get.find()),
      fenix: true,
    );
    Get.lazyPut<TransactionRepository>(
      () => TransactionRepositoryImpl(localDataSource: Get.find()),
      fenix: true,
    );
  }
}
