import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final String label;
  final TextInputAction textInputAction;
  final String Function(String) validator;

  const CustomTextField({Key key, this.readOnly, this.controller, this.textInputType, this.textCapitalization, this.label, this.textInputAction, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      validator: validator,
      textInputAction: textInputAction,
    );
  }
}

class CustomNoteField extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final String Function(String) validator;

  const CustomNoteField({Key key, this.controller, this.label, this.readOnly, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLength: 250,
      readOnly: readOnly,
      textCapitalization: TextCapitalization.sentences,
      maxLines: null,
      decoration: InputDecoration(
        counterText: "",
        labelText: label,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      validator: validator,
      textInputAction: TextInputAction.newline,
    );
  }
}

class CustomTextIconField extends StatelessWidget {

  final bool readOnly;
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final onPressed;

  const CustomTextIconField({Key key, this.readOnly, this.controller, this.label, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            icon,
            color: Colors.grey.shade600,
          ),
          onPressed: onPressed
        ),
      ),
    );
  }
}

class CustomTextIconsField extends StatelessWidget {

  final bool readOnly, obscureText;
  final TextEditingController controller;
  final String label;
  final onPressedEye, onPressedCopy;

  const CustomTextIconsField({Key key, this.readOnly, this.obscureText, this.controller, this.label, this.onPressedEye, this.onPressedCopy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      obscureText: obscureText,
      decoration: InputDecoration(
        counterText: "",
        labelText: label,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey.shade600,
              ),
              onPressed: onPressedEye,
            ),
            IconButton(
              icon: Icon(
                Icons.copy,
                color: Colors.grey.shade600,
              ),
              onPressed: onPressedCopy
            ),
          ],
        ),
      ),
    );
  }
}




