import 'package:dartz/dartz.dart';
import 'package:stokin_bloc/cores/failures/failures.dart';

import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class InsertProductUseCase {
  final ProductRepository productRepository;

  InsertProductUseCase(this.productRepository);

  Future<Either<DatabaseFailure, void>> call(ProductEntity product) async {
    return await productRepository.insertProduct(product);
  }
}

class GetProductsUseCase {
  final ProductRepository productRepository;

  GetProductsUseCase(this.productRepository);

  Future<Either<DatabaseFailure, List<ProductEntity>>> call() async {
    return await productRepository.getProducts();
  }
}

class DeleteProductUseCase {
  final ProductRepository productRepository;

  DeleteProductUseCase(this.productRepository);

  Future<Either<DatabaseFailure, void>> call(int id) async {
    return await productRepository.deleteProduct(id);
  }
}

class UpdateProductUseCase {
  final ProductRepository productRepository;

  UpdateProductUseCase(this.productRepository);

  Future<Either<DatabaseFailure, void>> call(ProductEntity product) async {
    return await productRepository.updateProduct(product);
  }
}
