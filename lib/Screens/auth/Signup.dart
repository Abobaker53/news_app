import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/Screens/Home.dart';
import 'package:news/Screens/Welcome.dart';
import 'package:news/Screens/auth/login.dart';
import '../widgets/costom_textFormField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmPasswordcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmPasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffE4E6EB),
                    ),
                  ),
                  Text(
                    "Again!",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1877F2),
                    ),
                  ),
                  Text(
                    "Signup to get Started",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: Color(0xffB0B3B8),
                    ),
                  ),
                  SizedBox(height: 20),
                  // email
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    Controller: emailcontroller,
                    title: "Username",
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Enter your email";
                      }
                      if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(value.trim())) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                    hint: "email",
                    maxLines: 1,
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  // password
                  CustomTextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    Controller: passwordcontroller,
                    title: "Password",
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Enter your Password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    hint: "password",
                    maxLines: 1,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  // confirm password
                  CustomTextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    Controller: confirmPasswordcontroller,
                    title: "Confirm Password",
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != passwordcontroller.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    hint: "confirm password",
                    maxLines: 1,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailcontroller.text.trim(),
                            password: passwordcontroller.text,
                          );
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message ?? "Sign up failed"),
                              backgroundColor: Color(0xffE53935),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.all(16),
                            ),
                          );
                        } finally {
                          if (mounted) setState(() => isLoading = false);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff1877F2),
                      foregroundColor: Color(0xffFFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(400, 50),
                    ),
                    child: isLoading
                        ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                        : Text("Sign Up"),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "or continue with",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                        color: Color(0xffB0B3B8),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffEEF1F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size(180, 50),
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Color(0xff0163E0),
                        ),
                        label: Text(
                          "Facebook",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xff667080),
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffEEF1F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size(180, 50),
                        ),
                        icon: SvgPicture.asset("assets/google.svg"),
                        label: Text(
                          "Google",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xff667080),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w200,
                              fontSize: 14,
                              color: Color(0xff1877F2),
                            ),
                          ),
                        ),
                      ),
                    ],
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