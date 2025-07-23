import 'package:amazone_clonee/controller/authcontroller.dart';
import 'package:amazone_clonee/feature/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Singup extends StatefulWidget {
  static const String routename = '/signup';
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  @override
  Widget build(BuildContext context) {
    final namecontroller = TextEditingController();
    final emailcontroller = TextEditingController();
    final passwordcontroller = TextEditingController();
    final retypecontroller = TextEditingController();
    Size size = MediaQuery.of(context).size;
    var signupkey = GlobalKey<FormState>();
    void submit(String email, String name, String password) {
      final isvalid = signupkey.currentState!.validate();
      if (!isvalid) {
        return;
      }
      signupkey.currentState!.save();
      Authcontroller().signupuser(
        name: name,
        email: email,
        password: password,
        context: context,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Amazone Clone",
          style: GoogleFonts.aBeeZee(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: signupkey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: size.height - 280,
            width: size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 1.4,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Create account  ",
                        style: GoogleFonts.poppins(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name.";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: "Your Name",
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      RegExp regExp = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      );
                      if (value!.isEmpty) {
                        return "Please enter email ";
                      } else {
                        if (!(regExp.hasMatch(value))) {
                          return "Please enter  valid email ";
                        }
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: "Email",
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      );
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else {
                        if (!(regex.hasMatch(value))) {
                          return 'Please enter a valid password ';
                        }
                        return null;
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      hintText: "Password",
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password must be atleast 8 characters ",
                        style: GoogleFonts.aDLaMDisplay(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      );
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else {
                        if (!regex.hasMatch(value)) {
                          return 'Please enter valid password';
                        }
                        if (!(passwordcontroller.text ==
                            retypecontroller.text)) {
                          return 'Please enter same passwords';
                        }

                        return null;
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: retypecontroller,
                    decoration: InputDecoration(
                      hintText: "Re-enter Password",
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      submit(
                        emailcontroller.text,
                        namecontroller.text,
                        passwordcontroller.text,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.8),
                        shape: BoxShape.rectangle,
                        color: Colors.orange,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width / 2 - 100,
                        vertical: 20,
                      ),
                      child: Text(
                        " Create account",
                        style: GoogleFonts.firaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  Text("Already a customer?"),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Signin()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.8),
                        shape: BoxShape.rectangle,
                        color: Colors.orangeAccent[100],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width / 2 - 120,
                        vertical: 12,
                      ),
                      child: Text(
                        " Sign In",
                        style: GoogleFonts.firaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
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
