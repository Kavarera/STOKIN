import 'package:get/get.dart';
import 'package:posapp/feature/posapp/presentation/pages/home/controllers/home_controller.dart';
import 'package:posapp/feature/posapp/presentation/pages/report/controllers/report_controller.dart';

import '../../domain/usecases/product_usecase.dart';
import '../../domain/usecases/transaction_usecase.dart';
import '../pages/home/views/home_view.dart';
import '../pages/report/views/report_view.dart';
import '../pages/transaction/controllers/transaction_controller.dart';
import '../pages/transaction/views/transaction_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<GetProductUsecase>(() => GetProductUsecase(Get.find()));

        Get.lazyPut<InsertProductUsecase>(
          () => InsertProductUsecase(Get.find()),
        );
        Get.lazyPut<UpdateProductUsecase>(
          () => UpdateProductUsecase(Get.find()),
        );
        Get.lazyPut<DeleteProductUsecase>(
          () => DeleteProductUsecase(Get.find()),
        );
        Get.lazyPut<DeleteTransactionUseCase>(
          () => DeleteTransactionUseCase(Get.find()),
        );
        Get.lazyPut<GetTransactionUseCase>(
          () => GetTransactionUseCase(Get.find()),
        );

        Get.lazyPut<HomeController>(
          () => HomeController(
            getProductUsecase: Get.find(),
            getTransactionUsecase: Get.find(),
            insertProductUsecase: Get.find(),
            updateProductUsecase: Get.find(),
            deleteProductUsecase: Get.find(),
            deleteTransactionUsecase: Get.find(),
          ),
        );
      }),
    ),

    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<GetProductUsecase>(() => GetProductUsecase(Get.find()));
        Get.lazyPut<InsertTransactionUseCase>(
          () => InsertTransactionUseCase(Get.find()),
        );
        Get.lazyPut<UpdateTransactionUseCase>(
          () => UpdateTransactionUseCase(Get.find()),
        );

        Get.lazyPut<TransactionController>(
          () => TransactionController(
            getProductUsecase: Get.find(),
            insertTransactionUseCase: Get.find(),
            updateTransactionUseCase: Get.find(),
          ),
        );
      }),
    ),

    GetPage(
      name: _Paths.REPORT,
      page: () => ReportView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<GetTransactionUseCase>(
          () => GetTransactionUseCase(Get.find()),
        );

        Get.lazyPut<ReportController>(
          () => ReportController(getTransactionUseCase: Get.find()),
        );
      }),
    ),
  ];
}
