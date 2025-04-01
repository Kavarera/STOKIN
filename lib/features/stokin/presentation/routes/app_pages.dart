import 'package:get/get.dart';

import '../../domain/usecases/category_usecases.dart';
import '../../domain/usecases/product_usecases.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../pages/home/controllers/home_controller.dart';
import '../pages/home/views/home_view.dart';

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
  ];
}
