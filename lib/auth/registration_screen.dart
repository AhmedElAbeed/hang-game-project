import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user_model.dart';
import '../screen/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instanceFor;
  
  @override
  final _formKey = GlobalKey<FormState>();

  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController  = new TextEditingController();
  final emailEditingController  = new TextEditingController();
  final passwordEditingController  = new TextEditingController();
  final confirmPasswordEditingController  = new TextEditingController();
bool passwordObscured = true;




  Widget build(BuildContext context) {
//firstnamefield
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value)
      {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

//firstnamefield

    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Second Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value)
      {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
//email
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.name,
      //validator: () {},
      onSaved: (value)
      {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
//pass
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
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
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
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

    //pass
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: passwordObscured,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value)
      {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration:  InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon : IconButton(onPressed: () {
            setState(() { passwordObscured = !passwordObscured;
            });
          },
            icon: Icon(
              passwordObscured ?
              Icons.visibility_off : Icons.visibility, ),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
//signup button

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,

        onPressed: (){
          signUp(emailEditingController.text, passwordEditingController.text);
//          createAccount(_name.text, _email.text, _password.text).then((user) {

          },
        child: Text("SignUp", textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),

      ),

    );


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
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
                            Image.asset( "assets/logo.png",
                                fit: BoxFit.contain)),
                        SizedBox(height: 40),
                  Row(
                  children: <Widget>[
                       Text('Sign UP',
                        style: TextStyle(fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),

                          Text("  it's qucik and easy",
                            style: TextStyle(fontSize: 10,
                                color: Colors.black38,
                              fontStyle: FontStyle.italic,),
                          ),
                ],
                  ),
                        SizedBox(height: 25),
                        firstNameField,
                        SizedBox(height: 20),
                        secondNameField,
                        SizedBox(height: 20),
                        emailField,
                        SizedBox(height: 20),
                        passwordField,
                        SizedBox(height: 20),
                        confirmPasswordField,
                        SizedBox(height: 20),
                        signUpButton,
                        SizedBox(height: 15),
                                             ],
                    )
                ),
              ),
            ),
          ),
        )
    );
  }



  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    // calling our user model
    UserModel userModel = UserModel();
    // sedning these values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    // writing all the values
    await firebaseFirestore.collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
user.updateDisplayName(userModel.firstName);
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
  }
}

