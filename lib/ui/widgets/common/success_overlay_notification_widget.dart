import 'package:flutter/material.dart';

import '../../../common/utils/extensions/buildcontext_extensions.dart';

class SuccessOverlayNotificationWidget extends StatefulWidget {
  const SuccessOverlayNotificationWidget({
    super.key,
    required this.notificationSuccessText, 
    required this.animationCompleteCallback, 
    required this.duration,
    required this.isShowSmile,
    this.emoji = '😊',
  });

  final String notificationSuccessText;
  final VoidCallback animationCompleteCallback;
  final Duration duration;
  final String emoji;
  final bool isShowSmile;


  @override
  State<SuccessOverlayNotificationWidget> createState() => _SuccessOverlayNotificationWidgetState();
}

class _SuccessOverlayNotificationWidgetState extends State<SuccessOverlayNotificationWidget> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  Future<void> startAnimation() async {
    await _controller.forward();

    await Future<void>.delayed(Duration(milliseconds: widget.duration.inMilliseconds - 1000));
        
    await _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: RelativeRectTween(
        begin: const RelativeRect.fromLTRB(0, -100, 16, 16),
        end: const RelativeRect.fromLTRB(0, kToolbarHeight + 10, 0, 0),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.bounceOut,
          reverseCurve: Curves.linear,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(
                top: 14,
                left: 16,
                right: 16,
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
              decoration: BoxDecoration(
                color:  const Color(0xFF0078AE),
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.notificationSuccessText,
                      //style:  context.theme.c3.copyWith(color: context.theme.main.primaryButtonTextColor),
                    ),
                  ),
                  if (widget.isShowSmile)
                  RichText(
                    text: TextSpan(
                      text: widget.emoji,
                      //style: context.theme.h4,
                    ),
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