/// Product class
/// -------------
/// Model used for a single item to be obtained
/// from the backend
class Product {
  // item information
  String name;
  String sku;
  String description;
  String category;
  double initialPrice;

  // constructor with description as optional
  Product(this.name, this.sku, this.description, this.category, this.initialPrice);
}