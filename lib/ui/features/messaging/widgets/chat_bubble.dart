import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        padding: isMe ? const EdgeInsets.only(left: 50) : const EdgeInsets.only(right: 50),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: isMe ? context.theme.main.myMessageBubble : context.theme.main.appBarBackgroundColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: context.theme.main.onPrimary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          color: context.theme.main.onPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
