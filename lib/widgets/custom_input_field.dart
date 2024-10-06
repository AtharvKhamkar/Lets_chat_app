// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lets_chat/utils/text_styles.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String label;
  final String hintText;
  final TextStyle hintStyle;
  final String? Function(String?) validator;
  final Icon? prefixIcon;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final bool readOnly;
  final Color colorText;
  final String errorMessage;
  final Color? hintColor;
  final int minLine;
  final List<TextInputFormatter> formatter;
  final AutovalidateMode autovalidateMode;
  final TextCapitalization textCapitalization;

  final List<String> listOfAutofill;
  const CustomInputField({
    super.key,
    required this.controller,
    required this.inputType,
    required this.label,
    required this.hintText,
    this.hintStyle = TextStyles.textFieldHintText,
    required this.validator,
    this.prefixIcon,
    required this.suffixIcon,
    this.isDense,
    required this.obscureText,
    required this.readOnly,
    required this.colorText,
    required this.errorMessage,
    this.hintColor,
    required this.minLine,
    required this.formatter,
    required this.autovalidateMode,
    required this.textCapitalization,
    required this.listOfAutofill,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.label,
            style: TextStyles.textFieldTitles,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              readOnly: widget.readOnly,
              enableSuggestions: true,
              textInputAction: TextInputAction.next,
              autofillHints: widget.listOfAutofill,
              textCapitalization: widget.textCapitalization,
              enabled: !widget.readOnly,
              autofocus: false,
              style: TextStyle(color: widget.colorText),
              keyboardType: widget.inputType,
              keyboardAppearance: Get.theme.colorScheme.brightness,
              controller: widget.controller,
              inputFormatters: widget.formatter,
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintStyle: TextStyles.textFieldHintText,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                errorStyle: const TextStyle(
                  color: Colors.redAccent,
                ),
                errorText:
                    widget.errorMessage.isEmpty ? null : widget.errorMessage,
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          !_obscureText
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_outlined,
                          color: Colors.grey.shade400,
                        ),
                      )
                    : null,
                suffixIconConstraints: (widget.isDense != null)
                    ? const BoxConstraints(maxHeight: 33)
                    : null,
              ),
              autovalidateMode: widget.autovalidateMode,
              validator: widget.validator,
              maxLines: widget.minLine > 1 ? null : 1,
              minLines: widget.minLine,
            ),
          )
        ],
      ),
    );
  }
}

class CustomInputField2 extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final String label;
  final String? Function(String?) validator;
  final void Function(String)? onFieldSubmitted;
  final Icon? prefixIcon;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final bool readOnly;
  final Color colorText;
  final String errorMessage;
  final Color hintColor;
  final int minLine;
  final Function? onChanged;
  final List<String> listOfAutofill;
  final List<TextInputFormatter> formatter;
  final AutovalidateMode autoValidateMode;
  final TextCapitalization textCapitalization;

  const CustomInputField2({
    super.key,
    required this.controller,
    required this.inputType,
    required this.hintText,
    required this.label,
    required this.validator,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false,
    this.readOnly = false,
    this.colorText = Colors.white,
    required this.errorMessage,
    this.hintColor = Colors.black45,
    this.minLine = 1,
    this.onChanged,
    required this.listOfAutofill,
    this.formatter = const [],
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<CustomInputField2> createState() => _CustomInputField2State();
}

class _CustomInputField2State extends State<CustomInputField2> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.label,
            style: TextStyles.textFieldTitles,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              textCapitalization: widget.textCapitalization,
              onChanged: widget.onChanged as void Function(String)?,
              readOnly: widget.readOnly,
              enableSuggestions: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: widget.onFieldSubmitted,
              autofillHints: widget.listOfAutofill,
              enabled: !widget.readOnly,
              autofocus: false,
              style: TextStyle(color: widget.colorText),
              keyboardType: widget.inputType,
              keyboardAppearance: Get.theme.colorScheme.brightness,
              controller: widget.controller,
              obscureText: (widget.obscureText && _obscureText),
              inputFormatters: widget.formatter,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: TextStyles.textFieldHintText,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  errorText:
                      widget.errorMessage.isEmpty ? null : widget.errorMessage,
                  errorStyle: const TextStyle(color: Colors.redAccent),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            !_obscureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                  suffixIconConstraints: (widget.isDense != null)
                      ? const BoxConstraints(maxHeight: 33)
                      : null),
              autovalidateMode: widget.autoValidateMode,
              validator: widget.validator,
              maxLines: widget.minLine > 1 ? null : 1,
              minLines: widget.minLine,
            ),
          )
        ],
      ),
    );
  }
}
