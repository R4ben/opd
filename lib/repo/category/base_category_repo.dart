
import '../../model/models.dart';

abstract class BaseCategoryRepo {
  Stream<List<CategoryModel>> getCategories();
  Stream<List<Product>> getCategoriesProducts(String categoryId);
}
