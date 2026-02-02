import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utilities/color_utility.dart';
import '../../utilities/style_utility.dart';
import '../../utilities/text_size_utility.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.textInputType,
    this.passwordObscure = false,
    this.onPrefixIconTap,
    this.ontapObscure,
    this.maxLine = 1,
    this.inputFormatter,
    this.preffixImage,
    this.validator,
    this.onTap,
    this.isEnable = true,
    this.readOnly = false,
    this.maxLength,
  });

  final TextEditingController controller;
  final String hintText;
  final String title;
  final TextInputType? textInputType;
  final bool? passwordObscure;
  final int? maxLine;
  final List<TextInputFormatter>? inputFormatter;
  final VoidCallback? onPrefixIconTap;
  final VoidCallback? ontapObscure;
  final VoidCallback? onTap;
  final String? preffixImage;

  final FormFieldValidator? validator;
  final bool? isEnable;
  final bool? readOnly;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: .start,
      children: [
        Text(title,style: StyleUtility.inputTextStyle,),
        SizedBox(height: 9.h),
        TextFormField(
          onTap: onTap,
          maxLength: maxLength,
          enabled: isEnable,
          readOnly: readOnly ?? false,
          obscureText: passwordObscure ?? false,
          controller: controller,
          validator: validator,
          textAlign: TextAlign.start,
          keyboardType: textInputType ?? TextInputType.text,
          maxLines: maxLine ?? 1,
          style: StyleUtility.inputTextStyle,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: inputFormatter,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(
              left: 20.w,
              top: 16,
              bottom: 16,
              right: 5.w,
            ),
            filled: true,
            fillColor: Colors.white,
            hintStyle: StyleUtility.hintTextStyle,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
             // borderSide: BorderSide.none,
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            errorStyle: StyleUtility.errorTextStyle.copyWith(
              fontSize: TextSizeUtility.textSize13.sp,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: ColorUtility.textFieldBorderColor,
              ),
            ),

            prefixIcon: preffixImage != null
                ? Padding(
                  padding:  EdgeInsets.all(12.sp),
                  child: Image.asset(preffixImage!,
                  color:
                    ColorUtility.color767C8C,),
                )
                : null,
            focusColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
