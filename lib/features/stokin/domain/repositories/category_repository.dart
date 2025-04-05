import 'package:dartz/dartz.dart';

import '../../../../cores/failures/failures.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<DatabaseFailure, List<CategoryEntity>>> getCategories();
  Future<Either<DatabaseFailure, void>> insertCategory(CategoryEntity category);
  Future<Either<DatabaseFailure, void>> deleteCategory(int id);
}
