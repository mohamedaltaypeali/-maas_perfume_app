import '../../data/perfumes_data.dart';

List<Perfume> smartSearchPerfumes(String query) {
  if (query.isEmpty) return worldPerfumes;
  final q = query.toLowerCase().trim();
  return worldPerfumes.where((p) =>
    p.name.toLowerCase().contains(q) ||
    p.brand.toLowerCase().contains(q) ||
    p.family.toLowerCase().contains(q) ||
    p.gender.toLowerCase().contains(q) ||
    p.category.toLowerCase().contains(q) ||
    p.allNotes.any((n) => n.toLowerCase().contains(q))
  ).toList();
}

List<Ingredient> smartSearchIngredients(String query) {
  if (query.isEmpty) return worldIngredients;
  final q = query.toLowerCase().trim();
  return worldIngredients.where((i) =>
    i.nameAr.toLowerCase().contains(q) ||
    i.nameEn.toLowerCase().contains(q) ||
    i.category.toLowerCase().contains(q) ||
    i.origin.toLowerCase().contains(q)
  ).toList();
}

List<ShopProduct> smartSearchProducts(String query) {
  if (query.isEmpty) return shopProducts;
  final q = query.toLowerCase().trim();
  return shopProducts.where((p) =>
    p.name.toLowerCase().contains(q) ||
    p.category.toLowerCase().contains(q) ||
    p.notes.any((n) => n.toLowerCase().contains(q))
  ).toList();
}
