import 'dart:math';

import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';

class Device {}

class Queries extends ChangeNotifier {
  Future<QuerySnapshot> listDevice(String group) async {
    Firestore db = connectDB();
    QuerySnapshot gs =
        await db.collection("group").where("name", "==", group).get();
    if (gs.size != 1) throw Exception("require only one group");
    CollectionReference q = db
        .collection("device")
        .where("groupList", "array-contains-any", [
          "0"]);
    return await q.get();
  }

  Firestore connectDB() {
    String _myfirebaseName =
        "myfirebase${Random(DateTime.now().millisecondsSinceEpoch).nextInt(100000)}";
    App app = initializeApp(
      apiKey: "AIzaSyDrO7W7Sb6RCpHTsY3GaP-zODRP_HtY4nI",
      authDomain: "road-to-iot.firebaseapp.com",
      databaseURL: "https://road-to-iot.firebaseio.com",
      projectId: "road-to-iot",
      storageBucket: "road-to-iot.appspot.com",
      //messagingSenderId: "307495712434",
      //appId: "1:307495712434:web:acc483c0c300549ff33bab",
      //measurementId: "G-1F2ZQXB15M"
      name: _myfirebaseName,
    );
    return app.firestore();
  }
}
