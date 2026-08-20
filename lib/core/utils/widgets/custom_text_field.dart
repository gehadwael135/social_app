import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.validator,  this.passwordIcon
  });
  final String text;
  final String label;
  final IconData icon;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? passwordIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      onTap: onTap,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
            return null;
          },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 20, color: Colors.blue),
        label: Text(label, style: TextStyle(color: Colors.blue, fontSize: 20)),
        hint: Text(
          text,
          style: TextStyle(color: const Color.fromARGB(255, 96, 123, 145)),
        ),
        suffixIcon:passwordIcon ,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
