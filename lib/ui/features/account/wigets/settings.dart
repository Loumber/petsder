import 'package:flutter/cupertino.dart';
import 'package:petsder/common/utils/extensions/buildcontext_extensions.dart';

class Settigs extends StatelessWidget {
  const Settigs({
    super.key,
    required this.signOut,
    required this.changePassword
  });

  final void Function()? changePassword;

  final void Function()? signOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 375,
          child: CupertinoButton(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: context.theme.main.inputFieldBackgroundColor, 
            onPressed: changePassword,
            child:  Text(
              'Изменить пароль',
              style: TextStyle(color: context.theme.main.inputFieldLabelColor),
            ),
          ),
        ),
        Container(
          color: context.theme.main.inputFieldBorderColor,
          height: 1,
          width: 375,
        ),
        SizedBox(
          width: 375,
          child: CupertinoButton(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: context.theme.main.primary, 
            onPressed: signOut,
            child: Text(
              'Выйти',
              style: TextStyle(color: context.theme.main.onPrimary),
            )
          ),
        )
      ],
    );
  }
}