import 'package:dartz/dartz.dart';
import 'package:posapp/feature/posapp/data/datasources/posapp_local_datasource.dart';
import 'package:posapp/feature/posapp/domain/entities/product_entity.dart';
import 'package:posapp/feature/posapp/domain/repositories/product_repository.dart';

import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final PosappLocalDatasource _localDatasource;
  ProductRepositoryImpl(this._localDatasource);
  @override
  Future<void> addProduct(ProductEntity product) async {
    try {
      await _localDatasource.insertProduct(ProductModel.fromEntity(product));
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  @override
  Future<void> deleteProduct(int productId) async {
    try {
      await _localDatasource.deleteProduct(productId);
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  @override
  Future<Either<Exception, List<ProductEntity>>> getProducts() async {
    try {
      final products = await _localDatasource.getProducts();
      return Right(products.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Exception('Error fetching products: $e'));
    }
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    try {
      await _localDatasource.updateProduct(ProductModel.fromEntity(product));
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }
}
