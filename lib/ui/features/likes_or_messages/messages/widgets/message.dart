import 'package:flutter/material.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';

// ignore: must_be_immutable
class Message extends StatelessWidget {
  Message({
    super.key,
    required this.photo,
    required this.name,
    required this.lastMessage,
    required this.onTap,
  });

  final String photo;
  final String name;
  final String? lastMessage;

  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Image(
                        image: NetworkImage(
                          photo,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: context.theme.main.messageName,
                        ),
                      ),
                      const SizedBox(height: 5),
                      if(lastMessage != null)
                      Text(
                        maxLines: 2,
                        lastMessage!,
                        style: TextStyle(
                          fontSize: 14,
                          color: context.theme.main.inputFieldLabelColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
