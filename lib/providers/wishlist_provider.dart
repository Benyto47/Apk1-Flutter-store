import 'package:apk1/models/cart_model.dart';
import 'package:apk1/models/wishlist_model.dart';
import 'package:flutter/cupertino.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWislistItems {
    return _wishlistItems;
  }

  void addRemouveProductsToWishlist({required String productId}){
    if(_wishlistItems.containsKey(productId)){
      removeOneItem(productId);
    }else{
      _wishlistItems.putIfAbsent(
        productId, () => 
        WishlistModel(id: DateTime.now().toString(), productId: productId));
    }
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _wishlistItems.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
