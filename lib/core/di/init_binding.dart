import 'package:get/get.dart';
import 'package:posapp/feature/posapp/data/datasources/posapp_local_datasource.dart';

import '../../feature/posapp/data/repositories/product_repository_impl.dart';
import '../../feature/posapp/data/repositories/transaction_repository_impl.dart';
import '../../feature/posapp/domain/repositories/product_repository.dart';
import '../../feature/posapp/domain/repositories/transaction_repository.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    //DATTASOURCE
    Get.lazyPut<PosappLocalDatasource>(
      () => PosappLocalDatasource(),
      fenix: true,
    );

    //REPOSITORY
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<TransactionRepository>(
      () => TransactionRepositoryImpl(Get.find()),
      fenix: true,
    );
  }
}
