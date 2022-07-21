// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/helpers/my_file_picker.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageView extends StatelessWidget {
  final String? profileImage;
  const ProfileImageView({
    Key? key,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            return CircleAvatar(
              radius: 64,
              backgroundColor: AppColors.primaryColor,
              backgroundImage: profileState.imageFile != null
                  ? FileImage(profileState.imageFile!)
                  : profileImage == null
                      ? const AssetImage(Images.profile)
                      : NetworkImage(profileImage!) as ImageProvider,
            );
          },
        ),
        Positioned(
          bottom: -10,
          left: 80,
          child: IconButton(
            onPressed: () async {
              File? pickedImage =
                  await MyFilePicker.pickImage(ImageSource.gallery);
              if (pickedImage != null) {
                context
                    .read<ProfileBloc>()
                    .add(PickImageEvent(imageFile: pickedImage));
              }
            },
            icon: const Icon(
              Icons.add_a_photo,
            ),
          ),
        ),
      ],
    );
  }
}
