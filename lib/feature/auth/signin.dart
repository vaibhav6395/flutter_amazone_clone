import 'package:amazone_clonee/controller/authcontroller.dart';
import 'package:amazone_clonee/feature/auth/singup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});
  static const String routename = '/signin';
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var signinkey = GlobalKey<FormState>();
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    Authcontroller authcontroller = Authcontroller();
    Future<void> Signin() async {
      await Authcontroller().Signinuser(
        context: context,
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
    }

    void submit() {
      final isvalid = signinkey.currentState!.validate();
      if (!isvalid) {
        return;
      }
      signinkey.currentState!.save();
      Signin();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Amazone Clone",
          style: GoogleFonts.aBeeZee(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
           physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
        child:Form(
            key: signinkey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    Text(
                      "Sign in with your email and Password and token ${authcontroller.token}",
                      style: GoogleFonts.ptSerif(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                      ),
                    ),

                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign In",
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "forgot Password",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value)) {
                          return "Please enter valide email ";
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
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        );
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        } else {
                          if (!regex.hasMatch(value)) {
                            return 'Enter valid password';
                          } else {
                            return null;
                          }
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
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
                    CheckboxListTile(
                      value: true,
                      onChanged: (value) {},
                      title: Text("Show password"),
                    ),
                    CheckboxListTile(
                      value: true,
                      onChanged: (value) {},
                      title: Text("Keep sign-in"),
                    ),

                    SizedBox(height: 30),

                    InkWell(
                      onTap: () {
                        submit();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width / 2 - 50,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(color: Colors.orangeAccent),
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.firaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      "-------------------------------New to Amazone------------------------- ",
                    ),
                    SizedBox(height: 30),

                    InkWell(
                      onTap: () {
                        // Router(routerDelegate: Signin())
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Singup(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.8),
                          shape: BoxShape.rectangle,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width / 2 - 140,
                          vertical: 20,
                        ),
                        child: Text(
                          " Create a new Amazone account",
                          style: GoogleFonts.firaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    // Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Condition of use privacy Notice",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    ));
  }
}
