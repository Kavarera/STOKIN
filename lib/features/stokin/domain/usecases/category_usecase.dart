import 'package:dartz/dartz.dart';
import 'package:stokin_bloc/cores/failures/failures.dart';

import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class InsertCategoryUseCase {
  final CategoryRepository categoryRepository;
  InsertCategoryUseCase(this.categoryRepository);

  Future<Either<DatabaseFailure, void>> call(CategoryEntity category) async {
    return await categoryRepository.insertCategory(category);
  }
}

class DeleteCategoryUseCase {
  final CategoryRepository categoryRepository;
  DeleteCategoryUseCase(this.categoryRepository);

  Future<Either<DatabaseFailure, void>> call(int id) async {
    return await categoryRepository.deleteCategory(id);
  }
}

class GetCategoriesUseCase {
  final CategoryRepository categoryRepository;
  GetCategoriesUseCase(this.categoryRepository);

  Future<Either<DatabaseFailure, List<CategoryEntity>>> call() async {
    return await categoryRepository.getCategories();
  }
}
