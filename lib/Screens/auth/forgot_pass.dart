import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/costom_textFormField.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController emailcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
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
                    "Forgot\nPassword ?",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffE4E6EB),
                    ),
                  ),
                  Text(
                    "Don't worry! it happens . Enter your email.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Color(0xffB0B3B8),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    Controller: emailcontroller,
                    title: "Email",
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter your email";
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return "Please Enter a valid email";
                      }
                      return null;
                    },
                    hint: "email",
                    maxLines: 1,
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                      if (formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                            email: emailcontroller.text.trim(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Reset email sent! Check your inbox."),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message ?? "Error occurred"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } finally {
                          setState(() => isLoading = false);
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
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Submit"),
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