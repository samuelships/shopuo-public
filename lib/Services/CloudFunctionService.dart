import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class CloudFunctionService {
  call({String name, Map data}) async {
    String host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2:5000'
        : 'localhost:5000';

    try {
      var callable = CloudFunctions.instance
          //  .useFunctionsEmulator(origin: "http://localhost:5000")
          .getHttpsCallable(functionName: name);

      var resp = await callable.call(data);
      return resp.data;
    } on PlatformException catch (e) {
      rethrow;
    }
  }
}
