import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.labelText,
    this.textEditingController,
    this.onSuffixIconPressed,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText,
    this.onChanged,
    this.onTap,
    this.formHeight,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);

  final String? labelText;
  final double? formHeight;
  final bool? obscureText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onSuffixIconPressed;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: const EdgeInsets.only(bottom: 200),
      maxLines: 1,
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      controller: textEditingController,
      showCursor: true,
      validator: validator,
      autocorrect: false,
      cursorColor: AppColors.primaryColor,
      keyboardType: keyboardType ?? TextInputType.text,
      inputFormatters: inputFormatters ?? [],
      onChanged: onChanged,
      onTap: onTap,
      style: AppStyles.color1Normal(16.sp).copyWith(
        letterSpacing: 0.8.sp,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
        suffixIconColor: AppColors.blackColor,
        labelText: labelText ?? '',
        labelStyle: AppStyles.color4Normal(16.sp).copyWith(height: 1.2.h),
        focusColor: AppColors.primaryColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: prefixIcon,
        suffixIcon: obscureText == true
            ? IconButton(
                onPressed: onSuffixIconPressed,
                icon: const Icon(
                  Icons.visibility_outlined,
                  color: AppColors.textColor3,
                ),
                focusColor: AppColors.primaryColor,
              )
            : obscureText == false
                ? IconButton(
                    onPressed: onSuffixIconPressed,
                    icon: const Icon(
                      Icons.visibility_off_outlined,
                      color: AppColors.textColor3,
                    ),
                  )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
          borderSide: BorderSide(
            width: 1.h,
            color: AppColors.innerBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
          borderSide: BorderSide(
            width: 1.sp,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
