import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
   DefaultTextFormField({super.key,required this.controller,required this.hintText,required this.prefixIcon,required this.keyboardType,
   required this.validationText, required this.onTap});
 TextEditingController controller ;
 String hintText;
 IconData prefixIcon;
 TextInputType keyboardType;
 String validationText;
  VoidCallback onTap;
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
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(20),
             borderSide:const BorderSide(color:Colors.black,)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey)
          ),
          errorStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius:BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.blueGrey)
          )
        ),
      ),
    );
  }
}
