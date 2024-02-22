import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:namaa_poject/home/pages/stepper_provider.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  Future<DocumentSnapshot<Map<String, dynamic>>?>? initName() async {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser!.uid);
      return await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
    }
    return null;
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  Future<void> initPlatformState(StepperProvider provider) async {
    // Init streams
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _stepCountStream = Pedometer.stepCountStream;

    // Listen to streams and handle errors
    _stepCountStream.listen(
      (event) async {
        print("_stepCountStream");
        provider.changesSteps(event.steps);
      },
    ).onError((e, s) {
      //
    });

    _pedestrianStatusStream.listen(
      (event) {
        print("_pedestrianStatusStream");
        provider.changePedestrianStatus(event.status);
      },
    ).onError((e, s) {
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        StepperProvider provider = StepperProvider();
        // initPlatformState(provider);
        return provider;
      },
      builder: (context, child) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: initName(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snap.hasError) return const Text("Something has error");
                    if (snap.data == null) {
                      return const Text("Empty data");
                    }
                    print(snap.data?.data());
                    return Text(
                      "${snap.data?.data()?["name"]}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    );
                  },
                ),
                Selector<StepperProvider, bool>(
                  selector: (context, provider) => provider.repeat,
                  builder: (context, value, child) {
                    return Lottie.asset('assets/Animation - 1708252866471.json',
                        repeat: value);
                  },
                ),
                Text(
                  "Your steps",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black38),
                ),
                Selector<StepperProvider, int>(
                  selector: (context, provider) => provider.steps,
                  builder: (context, value, child) {
                    return Text(
                      value.toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 30, color: Theme.of(context).primaryColor),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
