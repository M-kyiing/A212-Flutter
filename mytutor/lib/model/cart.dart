class Cart {
  String? cartID;
  String? subName;
  String? subPrice;
  String? cartqty;
  String? subID;
  String? pricetotal;

  Cart(
      {this.cartID,
      this.subName,
      this.subPrice,
      this.cartqty,
      this.subID,
      this.pricetotal});

  Cart.fromJson(Map<String, dynamic> json) {
    cartID = json['cart_id'];
    subName = json['subject_name'];
    subPrice = json['subject_price'];
    cartqty = json['cart_qty'];
    subID = json['subject_id'];
    pricetotal = json['pricetotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartID;
    data['subject_name'] = subName;
    data['subject_price'] = subPrice;
    data['cart_qty'] = cartqty;
    data['subject_id'] = subID;
    data['pricetotal'] = pricetotal;
    return data;
  }
}
