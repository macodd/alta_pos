/// Product class
/// -------------
/// Model used for a single item to be obtained
/// from the backend
class Product {
  // item information
  String name;
  String description;
  String category;
  String sku;
  double initialPrice;

  // constructor with description as optional
  Product(this.name, this.description, this.category, this.sku, this.initialPrice);

  Product.fromJson(doc) :
    this(
      doc['name'],
      doc['description'],
      doc['category'],
      doc['sku'],
      doc['price']
    );
}