import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/buttons.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
static String id='logIn';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String? _email;

  String? _password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: const Color(0xff284461),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Spacer(flex: 1),
              Image.asset('assets/scholar.png'),
              const Text(
                'Scholar Student',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    fontFamily: 'MEGZ'),
              ),
              const Spacer(flex: 2),
              const Row(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField(
        
                validation: (emailData) {
                  if (emailData!.isEmpty) {
                    return 'Enter your email';
                  } else if (RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,}$')
                      .hasMatch(emailData)) {
                    return null;
                  } else {
                    return 'invalid mail';
                  }
                },
                hint: 'Email',
                onChange: (data) {
                  _email = data;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                
                  isPassword: true,
                  validation: (passwordData) {
                    if (passwordData!.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                  onChange: (data) {
                    _password = data;
                  },
                  hint: 'Password'),
              const SizedBox(height: 16),
              CustomElevatedButton(
                  buttonName: 'Sign In',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {});
                      isLoading = true;
                      try {
                        await sinInMethod();
                        setState(() {});
                        isLoading = false;
                        snakeBar(context, 'you are logged in');
                        Navigator.pushNamed(context, ChatScreen.id
                        );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          snakeBar(context, 'No user found for that email.');
                          setState(() {});
                          isLoading = false;
                        } else if (ex.code == 'wrong-password') {
                          snakeBar(context,
                              'Wrong password provided for that user.');
                          setState(() {});
                          isLoading = false;
                        }
                      } catch (e) {
                        setState(() {});
                        isLoading = false;
                        snakeBar(context, 'there was an error');
                      }
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'signUp'),
                      child: const Text(
                        '  Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3),
            ]),
          ),
        ),
      ),
    );
  }

  void snakeBar(BuildContext context, String messg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(
          messg,
          style: const TextStyle(color: Color(0xff284461),fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 500, right: 20, left: 20),
    ));
  }

  Future<void> sinInMethod() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email!, password: _password!);
  }
}
