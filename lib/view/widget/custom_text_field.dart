import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:premedico/data/get_initial.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? icon;
  final TextInputType? inputType;
  final String? hint, label;
  final bool obscure;
  final Function? onTap;
  const CustomTextField(
      {super.key,
      this.controller,
      this.validator,
      this.inputType,
      this.icon,
      this.onTap,
      required this.hint,
      required this.label,
      this.obscure = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPass = false;

  @override
  void initState() {
    showPass = widget.obscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      obscureText: widget.obscure ? showPass : false,
      autocorrect: false,
      controller: widget.controller,
      keyboardType: widget.inputType,
      validator: widget.validator,
      maxLines: widget.inputType == TextInputType.multiline ? 3 : 1,
      minLines: 1,
      readOnly: widget.onTap != null,
      decoration: InputDecoration(
        icon: widget.icon != null
            ? Icon(
                widget.icon,
                color: appConstant.primaryColor,
              )
            : null,
        hintText: widget.hint!.tr,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 145, 138, 138),
        ),
        labelText: widget.label!.tr,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        suffixIcon: widget.obscure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPass = !showPass;
                  });
                },
                icon: Icon(
                  !showPass ? Icons.visibility : Icons.visibility_off,
                  color: appConstant.primaryColor,
                ))
            : null,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appConstant.primaryColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            )),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(30),
        )),
      ),
    );
  }
}
