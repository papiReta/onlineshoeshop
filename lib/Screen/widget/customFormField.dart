import 'package:flutter/material.dart';

class customFormField extends StatelessWidget {
  final String inputHintText;
  final bool isObscured;
  final FocusNode focusNode;
  final IconData icon;
  final Function onSaved;
  final String initalData;
  final String validationText;
  const customFormField(
      {Key key,
      this.inputHintText,
      this.isObscured,
      this.focusNode,
      this.onSaved,
      this.icon,
      this.initalData,
       this.validationText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: TextFormField(
          // focusNode: focusNode,
          cursorColor: Colors.deepOrange,
          obscureText: isObscured,
          onSaved: onSaved,
          validator: (value){
             if (value.isEmpty) {
                return validationText;
              }
              return null;             
          },
          decoration: InputDecoration(
              hintText: inputHintText,
              prefixIcon: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(icon, color: Colors.red)),
              border: InputBorder.none,
              contentPadding:EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
  }
}
