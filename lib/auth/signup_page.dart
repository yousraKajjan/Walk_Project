import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    print("Email -----------------------");
    print(args);
    emailController.text = (args as String);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context, false);
        //   },
        //   icon: Icon(Icons.arrow_back),
        // )
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: form,
          autovalidateMode: AutovalidateMode.disabled,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Sign up",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 30),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(height: 0.2),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(gapPadding: 1),
                        labelText: 'Email'),
                    controller: emailController,
                    validator: (value) {
                      if (value == null) {
                        return "Required";
                      }
                      return (!value.contains('@')) ? 'Use the @ char.' : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    // initialValue: '$args',
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(height: 0.2),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(gapPadding: 1),
                        hintText: 'Name'),
                    controller: nameController,
                    validator: (value) {
                      if (value == null) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: const TextStyle(height: 0.2),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(gapPadding: 1),
                        hintText: 'Password'),
                    obscureText: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null) {
                        return "Required";
                      }
                      return (value.length < 2) ? 'Too Short' : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (form.currentState?.validate() ?? false) {
                            String email = emailController.text;
                            String name = nameController.text;
                            UserCredential result = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            print(result);
                            //firstore firebase
                            if (FirebaseAuth.instance.currentUser != null) {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({"name": name, "age": 20, "score": 0});
                              print("finish write");
                            } else {
                              print('non fire store');
                            }
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", ModalRoute.withName('/'));
                            // final instance =
                            //     await SharedPreferences.getInstance();
                            // final result = await instance
                            //     .setStringList("data", [email, name]);
                            // final result = await cacheHelper
                            //     .setUser(User(name: name, email: email));
                            // if (result) {
                            //   Navigator.pushNamedAndRemoveUntil(context,
                            //       "/home", ModalRoute.withName('/'));
                            //   print("navigate to home");
                            // } else {
                            //   print("Something wrong");
                            // }
                          }
                        } catch (e) {
                          if (e is FirebaseException) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message ?? "")));
                          }
                        }
                      },
                      child: const Text("Sign up"),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("Have account"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class SignUpView extends StatefulWidget {
//   const SignUpView({super.key});

//   @override
//   State<SignUpView> createState() => _SignUpViewState();
// }

// class _SignUpViewState extends State<SignUpView> {
//   final emailController = TextEditingController();

//   final passwordController = TextEditingController();
//   final nameController = TextEditingController();

//   final GlobalKey<FormState> form = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var args = ModalRoute.of(context)?.settings.arguments;
//     print("Email -----------------------");
//     print(args);
//     // emailController.text = (args as String);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign up"),
//         // leading: IconButton(
//         //   onPressed: () {
//         //     Navigator.pop(context, false);
//         //   },
//         //   icon: Icon(Icons.arrow_back),
//         // )
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 50),
//         child: Form(
//           key: form,
//           autovalidateMode: AutovalidateMode.disabled,
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const Text("Sign up",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
//                   const SizedBox(height: 30),
//                   TextFormField(
//                     textInputAction: TextInputAction.next,
//                     style: const TextStyle(height: 0.2),
//                     decoration: const InputDecoration(
//                         border: OutlineInputBorder(gapPadding: 1),
//                         labelText: 'Email'),
//                     controller: emailController,
//                     validator: (value) {
//                       if (value == null) {
//                         return "Required";
//                       }
//                       return (!value.contains('@')) ? 'Use the @ char.' : null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     textInputAction: TextInputAction.next,
//                     style: const TextStyle(height: 0.2),
//                     decoration: const InputDecoration(
//                         border: OutlineInputBorder(gapPadding: 1),
//                         hintText: 'Name'),
//                     controller: nameController,
//                     validator: (value) {
//                       if (value == null) {
//                         return "Required";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     style: const TextStyle(height: 0.2),
//                     decoration: const InputDecoration(
//                         border: OutlineInputBorder(gapPadding: 1),
//                         hintText: 'Password'),
//                     obscureText: true,
//                     controller: passwordController,
//                     // validator: (value) {
//                     //   if (value == null) {
//                     //     return "Required";
//                     //   }
//                     //   return null;
//                     //   // return (value.length < 2) ? 'Too Short' : null;
//                     // },
//                   ),
//                   const SizedBox(height: 20),
//                   FractionallySizedBox(
//                       widthFactor: 1,
//                       child: ElevatedButton(
//                           onPressed: () async {
//                             if (form.currentState?.validate() ?? false) {
//                               String email = emailController.text;
//                               String name = nameController.text;
//                               String password = passwordController.text;
//                               signUp(email, name, password);
//                             }
//                           },
//                           child: const Text("Sign up"))),
//                   Center(
//                     child: TextButton(
//                         onPressed: () {
//                           Navigator.pop(context, false);
//                         },
//                         child: const Text("Have account")),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future signUp(String email, String password, String name) async {
//     try {
//       print('object');
//       UserCredential result = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       print(result);
//       if (FirebaseAuth.instance.currentUser != null) {
//         await FirebaseFirestore.instance
//             .collection("users")
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .set({"name": name, "age": 20});
//         print("finish write");
//       } // final instance =
//       //     await SharedPreferences.getInstance();
//       // final result = await instance
//       //     .setStringList("data", [email, name]);
//       // final result = await cacheHelper
//       //     .setUser(User(name: name, email: email));
//       // if (result) {
//       Navigator.pushNamedAndRemoveUntil(
//           context, "/home", ModalRoute.withName('/'));
//       //   print("navigate to home");
//       // } else {
//       //   print("Something wrong");
//       // }
//     } catch (e) {
//       if (e is FirebaseException) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(e.message ?? "")));
//       }
//     }
//   }
// // }
