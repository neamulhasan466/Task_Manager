import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

import '../screens/update_profile_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfile});
  final bool? fromUpdateProfile;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if(widget.fromUpdateProfile ?? false){
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
          );
        },
        child: Row(
          spacing: 8,
          children: [
            CircleAvatar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full Name',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),

                Text(
                  'email@gmail.com',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [IconButton(onPressed:_signOut, icon: Icon(Icons.logout))],
    );
  }

  Future<void>_signOut() async{
    await  AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.name, (predicate)=>false);
  }

  }
