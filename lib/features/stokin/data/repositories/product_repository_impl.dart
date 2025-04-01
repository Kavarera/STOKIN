import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:stokin/core/error/failure.dart';

import 'package:stokin/features/stokin/domain/entities/product_entity.dart';

import '../../domain/repositories/product_repository.dart';
import '../datasources/stokin_local_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final StokinLocalDataSource localDataSource;
  ProductRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await localDataSource.deleteProduct(id);
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await localDataSource.getProducts();
      return Right(products.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertProduct(ProductEntity product) async {
    try {
      await localDataSource.insertProduct(
        ProductModel(
          id: product.id,
          name: product.name,
          quantity: product.quantity,
          unit: product.unit,
          category: product.category,
        ),
      );
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    try {
      log(
        'scategory: ${product.category?.name}',
        name: "PRODUCTREPOSITORYIMPL",
      );
      await localDataSource.updateProduct(
        ProductModel(
          id: product.id,
          name: product.name,
          quantity: product.quantity,
          unit: product.unit,
          category: product.category,
        ),
      );
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
