import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
   DefaultTextFormField({super.key,required this.controller,required this.hintText, this.prefixIcon,required this.keyboardType,
   required this.validationText, required this.onTap, this.onSaved});
 TextEditingController controller ;
 String hintText;
 IconData? prefixIcon;
 TextInputType keyboardType;
 String validationText;
  VoidCallback onTap;
   void Function(String)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller:controller ,
        keyboardType: keyboardType,
        validator:(value)
        {
          if(value!.isEmpty)
            {
              return "$validationText must not be empty";
            }
          return null;
        },
        onTap:onTap,
        onFieldSubmitted: onSaved,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(20),
             borderSide:const BorderSide(color:Colors.black,)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:  BorderSide(color: Colors.grey.shade900)
          ),
          errorStyle: const TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius:BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.blueGrey)
          )
        ),
      ),
    );
  }
}
