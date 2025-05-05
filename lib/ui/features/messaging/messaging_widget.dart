import 'package:auto_route/annotations.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:petsder/ui/features/messaging/messaging_wm.dart';

@RoutePage()
class MessagingScreen extends ElementaryWidget<IMessagingWidgetModel> {
  const MessagingScreen({super.key}) : super(defaultMessagingWidgetModelFactory);

  @override
  Widget build(IMessagingWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: ClipOval(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Image(
                    image: NetworkImage(
                      'https://tiuhvynseevoicuqwteq.supabase.co/storage/v1/object/public/images/users/67inGecI5pVUXa1w6ZzTSxtco1y2/pets/67inGecI5pVUXa1w6ZzTSxtco1y2_lula/1746094202518',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Hatiko',
              style: TextStyle(fontSize: 20, color: wm.theme.main.onPrimary),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                          fillColor: wm.theme.main.inputFieldBackgroundColor,
                          border: const OutlineInputBorder(),
                          labelText: 'Введите новый пароль',
                        )
                        )
                      ),
                      const SizedBox(width: 10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: wm.theme.main.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.send_rounded,
                              color: wm.theme.main.onPrimary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )   
        ),
      );
  }
}
