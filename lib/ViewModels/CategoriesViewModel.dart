import 'package:flutter/cupertino.dart';
import 'package:shopuo/Models/CategoryModel.dart';
import 'package:shopuo/Services/FirestoreService.dart';
import 'package:shopuo/locator.dart';

class CategoriesViewModel with ChangeNotifier {
  // SERVICES
  final _firestoreService = locator<FirestoreService>();

  // PAGE DATA
  List<CategoryModel> categories = [];

  //  METHODS
  setUpModel() async {
    print("starting...");
    try {
      List<CategoryModel> result =
          await _firestoreService.getDataCollection<CategoryModel>(
        path: "categories",
        builder: ({data, documentID, snapshot}) => CategoryModel.fromMap(
          data: data,
          documentId: documentID,
        ),
      );

      categories = result;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
