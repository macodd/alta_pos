/// Cart
/// Stores the different items added by the user
/// and keeps track of the total to be paid
class Cart {
  // list of items
  Map<String, CartItem> _items;

  // constructor
  Cart(this._items);

  void addToCart(String sku, CartItem newItem) {
    if (_items.containsKey(sku)) {
      _items[sku]!.finalPrice += newItem.finalPrice;
    }
    else {
      _items[sku] = newItem;
    }
  }

  // gets the total
  double getCartTotal() {
    double total = 0.0;
    _items.values.forEach((product) {
      total += product.finalPrice;
    });
    return total;
  }

  // returns the amount of items in the cart
  int numOfItems() => _items.length;

  // removes the item at index
  void removeItem(String sku) => _items.remove(sku);

  // returns a specific item at index location
  CartItem? getItem(int index) => _items.values.elementAt(index);

}

/// Cart Item class
/// --------------
/// creates an item to be stored in the cart from a
/// product by adding the quantity
class CartItem {
  String name;
  String sku;
  double finalPrice;

  // overloads product
  CartItem(this.name, this.sku, this.finalPrice);
}
