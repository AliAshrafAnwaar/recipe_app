import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants/app_colors.dart';

class StyledTextField extends StatefulWidget {
  const StyledTextField(
      {required this.hint,
      required this.icon,
      this.isPassword,
      this.controller,
      this.timeCheck,
      this.readonly,
      this.password,
      this.isWhite,
      this.isNotifier,
      this.maxLines,
      super.key});

  final bool? readonly;
  final String hint;
  final IconData icon;
  final bool? isPassword;
  final bool? isNotifier;
  final TextEditingController? controller;
  final TextEditingController? password;
  final bool? timeCheck;
  final bool? isWhite;
  final int? maxLines;

  @override
  State<StyledTextField> createState() => _StyledTextfieldState();
}

class _StyledTextfieldState extends State<StyledTextField> {
  bool? isPasswordChecker;

  final _formKey = GlobalKey<FormState>();
  void validation() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context);
    }
  }

  @override
  void initState() {
    super.initState();
    isPasswordChecker =
        isPasswordChecker ?? (widget.isPassword == true ? true : false);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: (widget.maxLines != null) ? widget.maxLines : 1,
      onChanged: (widget.isNotifier == true) ? (e) {} : null,
      cursorColor: (widget.isWhite == true) ? Colors.white : null,
      style: (widget.isWhite == true)
          ? TextStyle(color: Colors.white)
          : Theme.of(context).textTheme.bodyMedium,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.hint}';
        } else if (value.length < 3 && widget.hint == "username") {
          return 'please enter at least ${widget.hint}';
        } else if (value.length != 11 && widget.hint == "phoneNumber") {
          return '${widget.hint} not correct ';
        } else if (value.contains("+") && widget.hint == "phoneNumber") {
          return '${widget.hint} should start with';
        }
        return null;
      },
      readOnly: widget.readonly ?? false,
      obscureText: isPasswordChecker!,
      decoration: InputDecoration(
        isDense: (widget.isWhite == true) ? true : false,
        hintText: widget.hint,
        contentPadding: (widget.isWhite == true)
            ? EdgeInsets.all(0)
            : const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        labelStyle: (widget.isWhite == true)
            ? TextStyle(color: Colors.white)
            : Theme.of(context).textTheme.headlineMedium,
        hintStyle: (widget.isWhite == true)
            ? TextStyle(color: Colors.white.withOpacity(0.5))
            : Theme.of(context).textTheme.bodySmall,
        errorStyle: const TextStyle(color: Colors.red),
        prefixIcon: (widget.maxLines != null || widget.hint == 'Title')
            ? null
            : Icon(
                widget.icon,
                color: (widget.isWhite == true)
                    ? Colors.white
                    : AppColors.hintColor,
                size: 20,
              ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40, // Ensure enough space for the icon
          minHeight: 0, // Remove extra height constraint
        ),
        enabledBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color:
                (widget.isWhite == true) ? Colors.white : AppColors.hintColor,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color:
                (widget.isWhite == true) ? Colors.white : AppColors.hintColor,
          ),
        ),
        focusColor:
            (widget.isWhite == true) ? Colors.white : AppColors.primaryText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color:
                (widget.isWhite == true) ? Colors.white : AppColors.primaryText,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColors.myRed,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColors.myRed,
            width: 1,
          ),
        ),
        suffixIcon: widget.isPassword == true
            ? IconButton(
                icon: Icon(
                  isPasswordChecker! ? Icons.visibility : Icons.visibility_off,
                  color: (widget.isWhite == true)
                      ? Colors.white
                      : AppColors.hintColor,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordChecker = !isPasswordChecker!;
                  });
                })
            : const SizedBox(),
      ),
    );
  }
}
