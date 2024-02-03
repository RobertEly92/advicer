import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  const CustomButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkResponse(
      onTap: ()=> onPressed(),
      child: Material(
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: themeData.colorScheme.secondary),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15), child: Text('Get Advice', style: themeData.textTheme.displayLarge,),),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
