import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namaa_poject/auth/signup_page.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  String emailValue = "";
  Color color = Colors.yellowAccent;

  @override
  Widget build(BuildContext context) {
    return TextColor(
      color: color,
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(title: const Text("Login"), actions: [
              IconButton(
                  onPressed: () {
                    context
                        .dependOnInheritedWidgetOfExactType<TextColor>()!
                        .updateColor(Colors.red);
                  },
                  icon: const Icon(Icons.color_lens_outlined))
            ]),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: form,
                // autovalidateMode:AutovalidateMode.always ,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Row(
                          children: [
                            // FaIcon(FontAwesomeIcons.longArrowAltDown,
                            // size: 30, color: Colors.deepPurple),
                            Text("Sign in",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Email'),
                          controller: emailController,
                          onChanged: (value) {
                            emailValue = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field required.';
                            }
                            return (!value.contains('@'))
                                ? 'Use the @ char.'
                                : null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Password'),
                          obscureText: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field required.';
                            }
                            return (value.length < 2) ? 'Too Short' : null;
                          },
                        ),
                        const RememberButton(),
                        FractionallySizedBox(
                            widthFactor: 1,
                            child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    if (form.currentState?.validate() ??
                                        false) {
                                      //   sent emailValue to server
                                      String email = emailController.text;

                                      String password = passwordController.text;
                                      UserCredential result = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                              email: email, password: password);
                                      print(result);
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          "/home", ModalRoute.withName('/'));
                                    }
                                  } catch (e) {
                                    if (e is FirebaseException) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(e.message ?? "")));
                                    }
                                  }
                                },
                                child: const Text("Sign in"))),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: OutlinedButton.icon(
                            icon: Image.asset(
                              "assets/images/Google__G__Logo.svg.png",
                              width: 15,
                              height: 15,
                            ),
                            onPressed: () {},
                            label: const Text(
                              "Sign in with Google",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: TextButton(
                              onPressed: () async {
                                ///1
                                var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    settings: RouteSettings(
                                        arguments: emailController.text),
                                    builder: (context) {
                                      return const SignUpView();
                                    },
                                  ),
                                );
                                print("result -----------------");
                                print(result);

                                ///2
                                // Navigator.pushNamed(context, "/sign_up",
                                //     arguments: emailController.text);
                                ///3
                                // Navigator.pushReplacementNamed(context, "/sign_up");
                                ///4
                                // Navigator.pushNamedAndRemoveUntil(
                                //     context, "/sign_up", ModalRoute.withName('/'));

                                // final result = await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) {
                                //           return const SignUpView();
                                //         },
                                //         settings: RouteSettings(
                                //             arguments: emailController.text)));
                                // emailController.text = result ?? "";
                                //  Navigator.pushNamed(context, "/sign_up");
                              },
                              child: const Text("Do not have account")),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }
}

class RememberButton extends StatefulWidget {
  const RememberButton({Key? key}) : super(key: key);

  @override
  State<RememberButton> createState() => _RememberButtonState();
}

class _RememberButtonState extends State<RememberButton> {
  bool checkValue = true;
  @override
  void didUpdateWidget(covariant RememberButton oldWidget) {
    print("object _RememberButtonState");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Row(
      children: [
        Checkbox(
          value: checkValue,
          onChanged: (value) {
            setState(() {
              checkValue = value ?? false;
            });
          },
        ),
        Text("Remember me ", style: TextStyle(color: color)),
      ],
    );
  }
}

class TextColor extends InheritedWidget {
  TextColor({super.key, required this.color, required super.child});

  Color color;

  updateColor(Color color) {
    color = this.color;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    print("object");
    return false;
  }
}










// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:namaa_poject/shared_preference/signup_page.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final emailController = TextEditingController();

//   final passwordController = TextEditingController();

//   final GlobalKey<FormState> form = GlobalKey<FormState>();

//   String emailValue = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Login"),
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 50),
//         child: Form(
//           key: form,
//           // autovalidateMode:AutovalidateMode.always ,
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const Row(
//                     children: [
//                       FaIcon(FontAwesomeIcons.adn,
//                           size: 30, color: Colors.deepPurple),
//                       Text(
//                         "Sign in",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w700),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                         border: OutlineInputBorder(), hintText: 'Email'),
//                     controller: emailController,
//                     onChanged: (value) {
//                       emailValue = value;
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'This field required.';
//                       }
//                       return (!value.contains('@')) ? 'Use the @ char.' : null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                         border: OutlineInputBorder(), hintText: 'Password'),
//                     obscureText: true,
//                     controller: passwordController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'This field required.';
//                       }
//                       return (value.length < 2) ? 'Too Short' : null;
//                     },
//                   ),
//                   const RememberButton(),
//                   FractionallySizedBox(
//                     widthFactor: 1,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         if (form.currentState?.validate() ?? false) {
//                           //   sent emailValue to server
//                           String email = emailController.text;

//                           String password = passwordController.text;
//                           UserCredential result = await FirebaseAuth.instance
//                               .signInWithEmailAndPassword(
//                                   email: email, password: password);
//                           print(result);
//                           Navigator.pushNamedAndRemoveUntil(
//                               context, "/home", ModalRoute.withName('/'));
//                         }
//                         // emailController.clear();
//                         // if (form.currentState?.validate() ?? false) {
//                         //   //   sent emailValue to server
//                         //   FirebaseAuth.instance.signInWithEmailAndPassword(
//                         //       email: emailController.text,
//                         //       password: passwordController.text);
//                         //   print('success');
//                         // }
//                       },
//                       child: const Text("Sign in"),
//                     ),
//                   ),
//                   FractionallySizedBox(
//                     widthFactor: 1,
//                     child: OutlinedButton.icon(
//                       icon: Image.asset(
//                         "assets/images/Google__G__Logo.svg.png",
//                         width: 15,
//                         height: 15,
//                       ),
//                       onPressed: () {},
//                       label: const Text(
//                         "Sign in with Google",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   Center(
//                     child: TextButton(
//                       onPressed: () async {
//                         ///1
//                         var result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             settings:
//                                 RouteSettings(arguments: emailController.text),
//                             builder: (context) {
//                               return const SignUpView();
//                             },
//                           ),
//                         );
//                         print("result -----------------");
//                         print(result);

//                         ///2
//                         // Navigator.pushNamed(context, "/sign_up",
//                         //     arguments: emailController.text);
//                         ///3
//                         // Navigator.pushReplacementNamed(context, "/sign_up");
//                         ///4
//                         // Navigator.pushNamedAndRemoveUntil(
//                         //     context, "/sign_up", ModalRoute.withName('/'));

//                         // final result = await Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) {
//                         //           return const SignUpView();
//                         //         },
//                         //         settings: RouteSettings(
//                         //             arguments: emailController.text)));
//                         // emailController.text = result ?? "";
//                         //  Navigator.pushNamed(context, "/sign_up");
//                       },
//                       child: const Text("Do not have account"),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RememberButton extends StatefulWidget {
//   const RememberButton({Key? key}) : super(key: key);

//   @override
//   State<RememberButton> createState() => _RememberButtonState();
// }

// class _RememberButtonState extends State<RememberButton> {
//   bool checkValue = true;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox(
//           value: checkValue,
//           onChanged: (value) {
//             setState(() {
//               checkValue = value ?? false;
//             });
//           },
//         ),
//         const Text("Remember me "),
//       ],
//     );
//   }
// }



