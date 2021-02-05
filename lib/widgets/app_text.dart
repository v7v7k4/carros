import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;


  AppText(this.label, this.hint, {this.password = false, this.controller, this.validator,
      this.keyboardType, this.textInputAction, this.focusNode, this.nextFocus});

  @override
  Widget build(BuildContext context) {
    //tudo que esta entre {} é opcional
    return TextFormField(
      keyboardType: keyboardType,
      keyboardAppearance: Brightness.light,
      textInputAction: textInputAction,
      controller: controller,
      obscureText: password,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: (String text){
        if(nextFocus!= null)
          FocusScope.of(context).requestFocus(nextFocus);
      }, //chamado quando clica no botão seguinte, concluir do teclado
      style: TextStyle(fontSize: 25, color: Colors.blue),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          labelText: label,
          labelStyle: TextStyle(fontSize: 25, color: Colors.grey),
          hintStyle: TextStyle(color: Colors.green, fontSize: 16),
          hintText: hint),
    );
  }
}
