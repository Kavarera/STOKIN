import 'package:get/get.dart';

import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/product_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../pages/home/controllers/home_controller.dart';
import '../pages/home/views/home_view.dart';
import '../pages/report/controller/report_controller.dart';
import '../pages/report/views/report_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        //Usecase
        Get.lazyPut<GetCategoriesUseCase>(
          () => GetCategoriesUseCase(Get.find()),
        );
        Get.lazyPut<GetProductsUseCase>(() => GetProductsUseCase(Get.find()));

        Get.lazyPut<GetTransactionsUseCase>(
          () => GetTransactionsUseCase(Get.find()),
        );

        Get.lazyPut<GetTransactionsByCategoryUseCase>(
          () => GetTransactionsByCategoryUseCase(Get.find()),
        );

        Get.lazyPut<GetTransactionsByDateUseCase>(
          () => GetTransactionsByDateUseCase(Get.find()),
        );

        Get.lazyPut<GetTransactionsByProductUseCase>(
          () => GetTransactionsByProductUseCase(Get.find()),
        );

        Get.lazyPut<GetTransactionsByTypeUseCase>(
          () => GetTransactionsByTypeUseCase(Get.find()),
        );

        Get.lazyPut<InsertCategoryUseCase>(
          () => InsertCategoryUseCase(Get.find()),
        );

        Get.lazyPut<InsertProductUseCase>(
          () => InsertProductUseCase(Get.find()),
        );

        Get.lazyPut<InsertTransactionUseCase>(
          () => InsertTransactionUseCase(Get.find()),
        );

        Get.lazyPut<DeleteCategoryUseCase>(
          () => DeleteCategoryUseCase(Get.find()),
        );

        Get.lazyPut<DeleteProductUseCase>(
          () => DeleteProductUseCase(Get.find()),
        );

        Get.lazyPut<DeleteTransactionUseCase>(
          () => DeleteTransactionUseCase(Get.find()),
        );

        Get.lazyPut<UpdateProductUseCase>(
          () => UpdateProductUseCase(Get.find()),
        );

        //Controller
        Get.lazyPut<HomeController>(
          () => HomeController(
            getTransactionByCategory: Get.find(),
            getTransactionByDate: Get.find(),
            getTransactionByProduct: Get.find(),
            getTransactionByType: Get.find(),
            updateProductUseCase: Get.find(),
            getCategoriesUseCase: Get.find(),
            getProductsUseCase: Get.find(),
            getTransactionsUseCase: Get.find(),
            insertCategoryUseCase: Get.find(),
            insertProductUseCase: Get.find(),
            insertTransactionUseCase: Get.find(),
            deleteCategoryUseCase: Get.find(),
            deleteProductUseCase: Get.find(),
            deleteTransactionUseCase: Get.find(),
          ),
        );
      }),
    ),

    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<GetTransactionsUseCase>(
          () => GetTransactionsUseCase(Get.find()),
        );
        Get.lazyPut<GetTransactionsByCategoryUseCase>(
          () => GetTransactionsByCategoryUseCase(Get.find()),
        );
        Get.lazyPut<GetTransactionsByDateUseCase>(
          () => GetTransactionsByDateUseCase(Get.find()),
        );
        Get.lazyPut<GetTransactionsByProductUseCase>(
          () => GetTransactionsByProductUseCase(Get.find()),
        );
        Get.lazyPut<GetTransactionsByTypeUseCase>(
          () => GetTransactionsByTypeUseCase(Get.find()),
        );

        Get.lazyPut<GetCategoriesUseCase>(
          () => GetCategoriesUseCase(Get.find()),
        );

        //controller
        Get.lazyPut<ReportController>(
          () => ReportController(
            getCategoriesUseCase: Get.find(),
            getTransactionsUseCase: Get.find(),
          ),
        );
      }),
    ),
  ];
}
