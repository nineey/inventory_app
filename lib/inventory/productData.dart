// data class for single product
// --> INVESTIGATE: how to save data into shared prefs
class ProductData {
  String text;
  String mhd;
  int quantity;

  ProductData({
    this.text,
    this.mhd,
    this.quantity = 0,
  });

}
