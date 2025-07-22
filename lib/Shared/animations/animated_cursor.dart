import 'package:flutter/material.dart';
import 'package:portfolio_web/core/theme/app_colors.dart';

class AnimatedCursor extends StatefulWidget {
  const AnimatedCursor({super.key});

  @override
  State<AnimatedCursor> createState() => _AnimatedCursorState();
}

class _AnimatedCursorState extends State<AnimatedCursor> {
  Offset _position = Offset(-100, -100); // off screen initially

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.pointerRouter.removeGlobalRoute(_handlePointerEvent);
    super.dispose();
  }

  void _handlePointerEvent(PointerEvent event) {
    setState(() {
      _position = event.position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            left: _position.dx - 15,
            top: _position.dy - 15,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 60),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                // border: Border.all(
                //   color: AppColors.accentOrange,
                //   width: 2,
                // ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentOrange.withOpacity(0.5),
                    blurRadius: 7,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
