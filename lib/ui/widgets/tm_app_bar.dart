import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import '../screens/update_profile_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfile});
  final bool? fromUpdateProfile;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {
  UserModel? _user;
  bool _isLoading = true; // tracks if user is still loading

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await AuthController.getUserData();
    if (kDebugMode) {
      print('DEBUG: Loaded user: ${user?.toJson()}');
    }
    if (mounted) {
      setState(() {
        _user = user;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Show placeholder while loading
      return AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.green),
            ),
            SizedBox(width: 8),
            Text('Loading...', style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    }

    if (_user == null) {
      // Show "Guest" if user data not found
      return AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.green),
            ),
            SizedBox(width: 8),
            Text('Guest', style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    }

    // Normal AppBar with user info
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (widget.fromUpdateProfile ?? false) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              backgroundImage:
              _user!.profilePic != null ? NetworkImage(_user!.profilePic!) : null,
              child: _user!.profilePic == null
                  ? const Icon(Icons.person, color: Colors.green)
                  : null,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _user!.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  _user!.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: _signOut,
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  Future<void> _signOut() async {
    await AuthController.clearUserData();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.name,
          (route) => false,
    );
  }
}
