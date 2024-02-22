// import 'package:flutter/material.dart';
// import 'package:namaa_poject/shared_preference/cache_helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // String email = "";
//   // String name = "";

//   @override
//   void initState() {
//     initData();
//     super.initState();
//   }

//   Future<User?> initData() async {
//     // final instance = await SharedPreferences.getInstance();
//     await Future.delayed(Duration(seconds: 2));
//     // List<String>? data = instance.getStringList("data");
//     return cacheHelper.getUser();
//     // email = data[0];
//     // name = data[1];
//     // setState(() {});
//     // return data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home")),
//       body: Center(
//           child: FutureBuilder(
//         future: initData(),
//         builder: (context, snap) {
//           if (snap.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }
//           if (snap.hasError) return const Text("Something has error");
//           if (snap.data == null) {
//             return const Text("Empty data");
//           }
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("name: ${snap.data!.name}"),
//               Text("Email: ${snap.data!.email}"),

//               // Text("name: ${snap.data![1]}"),
//               // Text("Email: ${snap.data![0]}"),

//               // Text("name: ${name}"),
//               // Text("Email: ${email}"),
//               ElevatedButton(
//                   onPressed: () async {
//                     //clear data
//                     // final instance = await SharedPreferences.getInstance();
//                     // final result = await instance.remove("data");
//                     final result = await cacheHelper.clearUser();

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namaa_poject/home/pages/stepper_page.dart';
import 'package:namaa_poject/home/pages/users_pages.dart';
import 'package:namaa_poject/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String email = "";
  // String name = "";
  List<Widget> Pages = [const StepperPage(), const UsersPages()];

  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Stepper Counter"),
            actions: [
              IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed("/");
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (context, value, child) {
              return BottomNavigationBar(
                  currentIndex: value.selectedPage,
                  onTap: (value) {
                    //ط1
                    // context.read<HomeProvider>().changeSelectedPage(value);
                    //ط2
                    Provider.of<HomeProvider>(context, listen: false)
                        .changeSelectedPage(value);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: 'Stepper'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.group), label: 'Users')
                  ]);
            },
          ),
          body: Consumer<HomeProvider>(
            builder: (context, value, child) =>
                Center(child: Pages[value.selectedPage]),
          ),
        );
      },
    );
  }
}
