import 'package:app_restaurant/tools/dimens_extension.dart';
import 'package:app_restaurant/tools/paths_images.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                child,
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: context.height(.545)),
                    Image.asset(images.backgroundLogin)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
