import 'package:dartz/dartz.dart';
import 'package:stokin/core/error/failure.dart';
import 'package:stokin/features/stokin/domain/entities/product_entity.dart';

import '../repositories/product_repository.dart';

class InsertProductUseCase {
  final ProductRepository productRepository;

  InsertProductUseCase(this.productRepository);

  Future<Either<Failure, void>> call(ProductEntity product) async {
    return await productRepository.insertProduct(product);
  }
}

class GetProductsUseCase {
  final ProductRepository productRepository;

  GetProductsUseCase(this.productRepository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await productRepository.getProducts();
  }
}

class DeleteProductUseCase {
  final ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, void>> call(int id) async {
    return await productRepository.deleteProduct(id);
  }
}

class UpdateProductUseCase {
  final ProductRepository productRepository;

  UpdateProductUseCase(this.productRepository);

  Future<Either<Failure, void>> call(ProductEntity product) async {
    return await productRepository.updateProduct(product);
  }
}
