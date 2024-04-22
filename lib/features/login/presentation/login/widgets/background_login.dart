import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/tools/paths/paths_images.dart';
import 'package:flutter/material.dart';

class BackgrounLogin extends StatelessWidget {
  const BackgrounLogin({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: context.height(),
              width: context.width(),
              color: Colors.black,
              child: Image.asset(
                images.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
