import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_screen.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //controllers
  final TextEditingController emailController = new TextEditingController();
  final _auth = FirebaseAuth.instanceFor;


  @override
  Widget build(BuildContext context) {
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
          hintText: "Enter Your Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          )
      ),
    );
    final resetButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.redAccent,
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,

          onPressed: () async {
            //    Navigator.push //Replacement
            //(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          await  FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value){
            Fluttertoast.showToast(msg: "Reset Password link sent Successfully");
              Navigator.push((context), MaterialPageRoute(builder: (context)=>LoginScreen()));
            });
          },
          child: Text("Send Link", textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
    Image.asset("assets/logo.png",
    fit: BoxFit.contain)),
    SizedBox(height: 35),
      Center(
        child: Text('Forgot Password?',
          style: TextStyle(fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 25),
      emailField,
    SizedBox(height: 25),
      resetButton,
      SizedBox(height: 25),
          ],
    ),
        ),
        ),
        ),
        )
    ),
    );
  }

}

