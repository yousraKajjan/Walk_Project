import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersPages extends StatefulWidget {
  const UsersPages({super.key});

  @override
  State<UsersPages> createState() => _UsersPagesState();
}

class _UsersPagesState extends State<UsersPages> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    // final instance = await SharedPreferences.getInstance();
    // await Future.delayed(Duration(seconds: 2));
    // List<String>? data = instance.getStringList("data");]
    // return cacheHelper.getUser();
    // email = data[0];
    // name = data[1];
    // setState(() {});
    // return data;
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseFirestore.instance
          .collection("users")
          .orderBy("score", descending: true)
          .get();
      // return null;
    }
    return null;
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initData(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snap.hasError) return const Text("Something has error");
        if (snap.data == null) {
          return const Text("Empty data");
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: snap.data?.docs.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "name: ${snap.data!.docs[index].data()["name"]}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "name:",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "Age: ${snap.data!.docs[index].data()["age"]}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ]),
                    Text(
                      " ${snap.data!.docs[index].data()["score"]}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            );
          },
        );
        // return Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text("name: ${snap.data!.data()?["name"]}"),
        //     Text("Age: ${snap.data!.data()?["age"]}"),
        //
        //     // Text("name: ${snap.data![1]}"),
        //     // Text("Email: ${snap.data![0]}"),
        //
        //     // Text("name: ${name}"),
        //     // Text("Email: ${email}"),
        //     // ElevatedButton(
        //     //     onPressed: () async {
        //     //       //clear data
        //     //       // final instance = await SharedPreferences.getInstance();
        //     //       // final result = await instance.remove("data");
        //     //       final result = await cacheHelper.clearUser();
        //     //
        //     //       if (result) {
        //     //         Navigator.pushReplacementNamed(context, "/login");
        //     //       }
        //     //     },
        //     //     child: Text("Clear data"))
        //   ],
        // );
      },
    );
  }
}
