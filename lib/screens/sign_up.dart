import 'package:chat_app/widgets/buttons.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  SignUp({super.key});
static String id='signUp';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  String? _email;

  String? _password;

  GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff284461),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          child: Form(
            key: _formKey,
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
                    'Sign Up',
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
                      return 'This field is required';
                    } else if (RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,}$')
                        .hasMatch(emailData)) {
                      return null;
                    } else {
                      return 'invalid email';
                    }
                  },
                  hint: 'Email',
                  onChange: (data) {
                    _email = data;
                  }),
              const SizedBox(height: 16),
              CustomTextField(
                
                validation: (passWordData) {
                  if (passWordData!.isEmpty) {
                    return 'this fied is required';
                  }
                  return null;
                },
                hint: 'Password',
                onChange: (data) {
                  _password = data;
                },
              ),
              const SizedBox(height: 16),
              CustomElevatedButton(
                buttonName: 'Sign Up',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {});
                    isLoading = true;
                    try {
                      await createNewaccount();
                      setState(() {});
                      isLoading = false;
                      snakeBar(context, 'Singned Up successfully');
                    } on FirebaseAuthException catch (ex) {
                      if (ex.code == 'weak-password') {
                        snakeBar(context, 'weak-password');
                      } else if (ex.code == 'email-already-in-use') {
                        snakeBar(context,
                            'The email address is already in use by another account');
                      }
                    } catch (ex) {
                      setState(() {});
                      isLoading = false;
                      snakeBar(context, 'there was an error');
                    }
                  }
                },
              ),
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
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '  Sign In',
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
      content: Text(
        messg,
        style: const TextStyle(color: Color(0xff284461)),
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<void> createNewaccount() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email!,
      password: _password!,
    );
  }
}
