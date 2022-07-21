import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final UserModel userModel;
  final VoidCallback onPressed;
  const UserItem({
    Key? key,
    required this.userModel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      onTap: onPressed,
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: 30,
        backgroundImage: userModel.profileImage == null
            ? const AssetImage(Images.profile)
            : NetworkImage(userModel.profileImage!) as ImageProvider,
      ),
      title: Text(
        userModel.name,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: MediaQuery.of(context).platformBrightness == Brightness.light
          ? Text(userModel.status ? 'online' : 'offline')
          : Text(
              userModel.status ? 'online' : 'offline',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
    );
  }
}
