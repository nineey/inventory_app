// data class for single product
// --> investigate how to save data into database / shared prefs
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
