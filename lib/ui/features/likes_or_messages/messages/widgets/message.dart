import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';

// ignore: must_be_immutable
class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.photo,
    required this.name,
    required this.lastMessage,
    required this.onTap,
    required this.lastMessageTime,
  });

  final String photo;
  final String name;
  final String? lastMessage;

  final String lastMessageTime;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 35,
                child: ClipOval(
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: Image(
                      image: NetworkImage(
                        photo,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: context.theme.main.messageName,
                          ),
                        ),
                        Text(
                          lastMessageTime,
                          style: TextStyle(
                            fontSize: 16,
                            color: context.theme.main.messageName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    if (lastMessage != null) ...[
                      Text(
                        maxLines: 1,
                        lastMessage!,
                        style: TextStyle(
                          fontSize: 18,
                          color: context.theme.main.inputFieldLabelColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
