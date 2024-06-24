import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CookieTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool border;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final TextAlign? textAlign;
final void Function(String)? onChanged;

  const CookieTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText = false,
      this.validator,
      this.maxLines,
      this.borderRadius,
      this.maxLength,
      this.minLines,
      this.keyboardType,
      this.inputFormatters, this.style,  this.textAlign, this.onChanged})
      : border = true;

  const CookieTextField.outline({
    super.key,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.maxLines,
    this.borderRadius,
    this.maxLength,
    this.minLines,
    this.keyboardType,
    this.inputFormatters, this.style,  this.textAlign, this.onChanged,
  }) : border = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      maxLines: maxLines,
      textAlign:  textAlign ?? TextAlign.start,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      style: style ?? Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(16),
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        focusedBorder: OutlineInputBorder(
          borderSide: border
              ? BorderSide(
                  color: Theme.of(context).colorScheme.onSurface, width: 1)
              : const BorderSide(style: BorderStyle.none),
          borderRadius: borderRadius ?? BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          borderSide: border
              ? BorderSide(color: Theme.of(context).colorScheme.onSurface)
              : const BorderSide(style: BorderStyle.none),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: border
              ? BorderSide(color: Theme.of(context).colorScheme.onSurface)
              : const BorderSide(style: BorderStyle.none),
          borderRadius: borderRadius ?? BorderRadius.circular(16),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
