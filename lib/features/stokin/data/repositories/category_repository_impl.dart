import 'package:dartz/dartz.dart';

import '../../../../cores/failures/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/stokin_local_data_source.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final StokinLocalDataSource localDataSource;
  CategoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<DatabaseFailure, void>> deleteCategory(int id) async {
    try {
      await localDataSource.deleteCategory(id);
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseFailure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await localDataSource.getCategories();
      return Right(categories.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<DatabaseFailure, void>> insertCategory(
    CategoryEntity category,
  ) async {
    try {
      await localDataSource.insertCategory(
        CategoryModel(id: category.id, name: category.name),
      );
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
