import 'package:stokin/features/stokin/domain/repositories/category_repository.dart';

class InsertCategoryUseCase {
  final CategoryRepository categoryRepository;
  InsertCategoryUseCase(this.categoryRepository);
}

class DeleteCategoryUseCase {
  final CategoryRepository categoryRepository;
  DeleteCategoryUseCase(this.categoryRepository);
}

class GetCategoriesUseCase {
  final CategoryRepository categoryRepository;
  GetCategoriesUseCase(this.categoryRepository);
}
