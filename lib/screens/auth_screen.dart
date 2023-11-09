import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  var _email = '';
  var _password = '';
  var _name = '';

  void submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    try {
      if (_isLogin) {
         await _firebase.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _email, password: _password);

        FirebaseFirestore.instance.collection('user').doc(userCredentials.user!.uid).set({
          'user_name' : _name,
          'email_address' : _email,
          'password' : _password,
        });
      }
    } on FirebaseException catch (error) {
      if (error.code == 'email-already-in-use') {
        // .....
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication Failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/university.png',
                    fit: BoxFit.cover,
                    height: 170,
                    // color: Colors.blue.shade800,
                    color: Colors.purple,
                    alignment: Alignment.center,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        _isLogin ? 'Login' : 'Create Account',
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_isLogin)
                        const Text(
                          'Please sign in to continue.',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (!_isLogin)
                        Card(
                          shadowColor: Colors.black,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'FULL NAME',
                              icon: Icon(Icons.person_2_outlined),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.name,
                            enableSuggestions: true,
                            autocorrect: true,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.length < 5) {
                                return 'Enter a Valid Name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _name = value!;
                            },
                          ),
                        ),
                      Card(
                        shadowColor: Colors.black,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'EMAIL',
                            icon: Icon(Icons.email_outlined),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 17, horizontal: 10),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Enter Valid Email Address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
                      ),
                      Card(
                        shadowColor: Colors.black,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'PASSWORD',
                            icon: Icon(Icons.lock_open_outlined),
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.length < 4) {
                              return 'Enter Valid Password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade600,
                              Colors.blue.shade300,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: submit,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _isLogin ? 'LOGIN' : 'SIGN UP',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(Icons.arrow_forward_rounded),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //previously we were using expanded on as a parent for align to solve the
                  //problem but it was messing with the singlechildscrollview widget.
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: RichText(
                        text: TextSpan(
                          text: _isLogin
                              ? 'Don\'t have an account? '
                              : 'Already have a account? ',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: _isLogin ? 'Sign up' : 'Sign in',
                                style: const TextStyle(
                                  color: Colors.blue,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
