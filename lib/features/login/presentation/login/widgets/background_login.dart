import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/tools/paths/paths_images.dart';
import 'package:flutter/material.dart';

class BackgrounLogin extends StatefulWidget {
  const BackgrounLogin({
    super.key,
    required this.child,
    this.viewBottomNavigationBar = false,
    this.bottomNavigationBar,
  });

  final Widget child;
  final bool? viewBottomNavigationBar;
  final Widget? bottomNavigationBar;

  @override
  State<BackgrounLogin> createState() => _BackgrounLoginState();
}

class _BackgrounLoginState extends State<BackgrounLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          SafeArea(child: SingleChildScrollView(child: widget.child)),
        ],
      ),
      bottomNavigationBar:
          widget.viewBottomNavigationBar! ? widget.bottomNavigationBar : null,
    );
  }
}
