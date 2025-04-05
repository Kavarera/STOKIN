import 'package:dartz/dartz.dart';
import 'package:stokin_bloc/cores/failures/failures.dart';
import 'package:stokin_bloc/features/stokin/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<DatabaseFailure, List<ProductEntity>>> getProducts();
  Future<Either<DatabaseFailure, void>> insertProduct(
    ProductEntity productEntity,
  );
  Future<Either<DatabaseFailure, void>> updateProduct(
    ProductEntity productEntity,
  );
  Future<Either<DatabaseFailure, void>> deleteProduct(int id);
}
