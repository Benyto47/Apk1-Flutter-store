import 'package:apk1/models/viewed_model.dart';
import 'package:flutter/cupertino.dart';

class ViewedProdProvider with ChangeNotifier {
  Map<String, ViewedProdModel> _viewedProdlistItems = {};

  Map<String, ViewedProdModel> get getViewedProdlistItems {
    return _viewedProdlistItems;
  }

  void addProductToHistory({required String productId}) {
    _viewedProdlistItems.putIfAbsent(
        productId,
        () => ViewedProdModel(
            id: DateTime.now().toString(), productId: productId));

    notifyListeners();
  }

  void clearHistory() {
    _viewedProdlistItems.clear();
    notifyListeners();
  }
}
