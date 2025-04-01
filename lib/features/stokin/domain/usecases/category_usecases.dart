import 'package:dartz/dartz.dart';
import 'package:stokin/features/stokin/domain/entities/category_entity.dart';
import 'package:stokin/features/stokin/domain/repositories/category_repository.dart';

import '../../../../core/error/failure.dart';

class InsertCategoryUseCase {
  final CategoryRepository categoryRepository;
  InsertCategoryUseCase(this.categoryRepository);

  Future<Either<Failure, void>> call(CategoryEntity category) async {
    return await categoryRepository.insertCategory(category);
  }
}

class DeleteCategoryUseCase {
  final CategoryRepository categoryRepository;
  DeleteCategoryUseCase(this.categoryRepository);

  Future<Either<Failure, void>> call(int id) async {
    return await categoryRepository.deleteCategory(id);
  }
}

class GetCategoriesUseCase {
  final CategoryRepository categoryRepository;
  GetCategoriesUseCase(this.categoryRepository);

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await categoryRepository.getCategories();
  }
}
