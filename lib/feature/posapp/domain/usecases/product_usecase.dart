import 'dart:developer';

import 'package:posapp/feature/posapp/domain/entities/product_entity.dart';

import '../repositories/product_repository.dart';

class InsertProductUsecase {
  final ProductRepository productRepository;

  InsertProductUsecase(this.productRepository);

  Future<void> call(ProductEntity product) async {
    try {
      await productRepository.addProduct(product);
    } catch (e) {
      log(e.toString(), name: 'InsertProductUsecase');
    }
  }
}

class GetProductUsecase {
  final ProductRepository productRepository;

  GetProductUsecase(this.productRepository);

  Future<List<ProductEntity>> call() async {
    var data = await productRepository.getProducts();
    return data.fold((l) {
      log(l.toString(), name: 'GetProductUsecase');
      return [];
    }, (r) => r);
  }
}

class UpdateProductUsecase {
  final ProductRepository productRepository;

  UpdateProductUsecase(this.productRepository);

  Future<void> call(ProductEntity product) async {
    try {
      await productRepository.updateProduct(product);
    } catch (e) {
      log(e.toString(), name: 'UpdateProductUsecase');
    }
  }
}

class DeleteProductUsecase {
  final ProductRepository productRepository;

  DeleteProductUsecase(this.productRepository);

  Future<void> call(int productId) async {
    try {
      await productRepository.deleteProduct(productId);
    } catch (e) {
      log(e.toString(), name: 'DeleteProductUsecase');
    }
  }
}
