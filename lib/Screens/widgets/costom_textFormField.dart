import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.Controller,
    required this.title,
    required this.validator,
    required this.hint,
    required this.maxLines,
    this.keyboardType,
    required this.obscureText,
  });

  final TextEditingController Controller;
  final String title;
  final String hint;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xffB0B3B8),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          controller: Controller,
          obscureText: obscureText,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Color(0xff282828)),
            ),
            fillColor: Color(0xff282828),
            filled: true,
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ],
    );
  }
}
