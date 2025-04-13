import 'package:dartz/dartz.dart';
import 'package:posapp/feature/posapp/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Exception, List<ProductEntity>>> getProducts();
  Future<void> addProduct(ProductEntity product);
  Future<void> updateProduct(ProductEntity product);
  Future<void> deleteProduct(int productId);
}
