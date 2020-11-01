import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopuo/Models/ProductModel.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/FirestoreService.dart';
import 'package:shopuo/Services/NavigationService.dart';

import '../locator.dart';

class OnSaleViewModel with ChangeNotifier {
  // services
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();

  // page data
  DocumentSnapshot last;
  Map<String, List<ProductModel>> products = {"0": []};
  bool allDataFetched = false;

  // other variables
  bool _fetched = false;
  get fetched => _fetched;
  set fetched(value) {
    _fetched = value;
    notifyListeners();
  }

  bool _fetching = false;
  get fetching => _fetching;
  set fetching(value) {
    _fetching = value;
    notifyListeners();
  }

  // getters and setters

  // methods
  setUpModel() {
    if (!fetched) {
      fetchProducts();
    }
  }

// methods
  getProducts({queryBuilder}) async {
    List<ProductModel> results =
        await _firestoreService.getDataCollection<ProductModel>(
      path: "products",
      builder: ({data, documentID, snapshot}) => ProductModel.fromMap(
        data: data,
        documentId: documentID,
        snapshot: snapshot,
      ),
      queryBuilder: queryBuilder,
    );

    if (results.length != 0) {
      int length = products.keys.length + 1;
      int currentProductLength = results.length;
      products["$length"] = results;
      last = results[currentProductLength - 1].snapshot;
    } else {
      allDataFetched = true;
    }
  }

  fetchProducts() async {
    if (allDataFetched || fetching) return;

    fetching = true;

    myQuery1(CollectionReference query) => query
        .orderBy(
          "time_added",
          descending: true,
        )
        .limit(10);

    myQuery2(CollectionReference query) => query
        .orderBy(
          "time_added",
          descending: true,
        )
        .startAfterDocument(last)
        .limit(10);

    if (last == null) {
      await getProducts(queryBuilder: myQuery1);

      fetched = true;
      fetching = false;
      notifyListeners();
    } else {
      fetching = true;
      await getProducts(queryBuilder: myQuery2);
      fetching = false;
      notifyListeners();
    }
  }
}
