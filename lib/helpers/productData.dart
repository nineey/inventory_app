// data class for single product
class ProductData {
  int id;
  String name;
  String mhd;
  int quantity;

  ProductData({
    this.id,
    this.name,
    this.mhd,
    this.quantity = 0,
  });

  // Convert a ProductData into a Map to store into DB
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mhd': mhd,
      'quantity': quantity,
    };
  }

}