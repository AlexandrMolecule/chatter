import 'package:flutter/material.dart';

class InitialBackgroundView extends StatelessWidget {
  const InitialBackgroundView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          right: -85,
          child: Image.asset('assets/top-right-logo.png', )
        ),
        Positioned(
          bottom: -50,
          right: -50,
          child: Image.asset('assets/bottom-right-logo.png', height: 200,)
        ),
      ],
    );
  }
}