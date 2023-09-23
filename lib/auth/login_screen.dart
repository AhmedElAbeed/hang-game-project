
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hang_game_project/auth/registration_screen.dart';
import 'package:hang_game_project/screen/home_screen.dart';

import 'forgotPassword_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  //controllers
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool passwordObscured = true;
//firebase
  final _auth = FirebaseAuth.instanceFor;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );

//password field
    final passwordField = TextFormField(

      autofocus: false,
      controller: passwordController,
      obscureText: passwordObscured,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          // function eye lock w unlock visitbility
          suffixIcon : IconButton(onPressed: () {
            setState(() { passwordObscured = !passwordObscured;
            });
          },
          icon: Icon(
            passwordObscured ?
            Icons.visibility_off : Icons.visibility, ),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery
            .of(context)
            .size
            .width,

        onPressed: () {
      //    Navigator.push //Replacement
          //(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          signIn(emailController.text, passwordController.text);
        },
        child: Text("Login", textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),

      ),

    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[

                        SizedBox(
                            height: 200,
                            child:
                            Image.asset("assets/logo.png",
                                fit: BoxFit.contain)),
                        SizedBox(height: 45),

                        emailField,
                        SizedBox(height: 25),
                        passwordField,
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(width: 200),
                            GestureDetector(onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen()));
                            },
                              child: Text("Forgot Password?", style:
                              TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15),

                              ),
                            ),
                          ],

                        ),
                        SizedBox(height: 15),
                        loginButton,
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't Have an account? "),
                            GestureDetector(onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                            },
                              child: Text("SignUp", style:
                              TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),

                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 35),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: (){
                                print('google Pressed');
                              },
                              child: Image.asset('assets/google.png', width: 45),
                            ),
                            SizedBox(width: 5.0,),
                            GestureDetector(
                              onTap:(){
                                print('facebook pressed');
                              },
                              child: Image.asset('assets/fbook.png', width: 45),),
                          ],
                        ),
                      ],
                    )
                ),
              ),
            ),
          ),
        )
    );
  }


  //login

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) =>
      {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())),
      });
    }
  }
}