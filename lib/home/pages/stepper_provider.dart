import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StepperProvider extends ChangeNotifier {
  bool repeat = false;
  int steps = 0;

  void changesSteps(int newSteps) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({"score": newSteps});
      }
      steps = newSteps;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void changePedestrianStatus(String status) {
    if (status == "walking") {
      repeat = true;
    } else if (status == "stopped") {
      repeat = false;
    }

    notifyListeners();
  }
}
