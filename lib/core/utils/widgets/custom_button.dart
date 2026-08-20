import 'package:flutter/material.dart';

class cutomButton extends StatelessWidget {
  const cutomButton({super.key, this.child, this.onPressed});
  final Widget? child;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50,
      child:  ElevatedButton(style: ElevatedButton.styleFrom(
      
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            )
        ),
            onPressed:onPressed, child: child)
     ,)
     ;
  }
}