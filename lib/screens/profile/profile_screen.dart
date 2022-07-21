import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/enums/snackbar_message.dart';
import 'package:chatapp/global_widgets.dart';
import 'package:chatapp/screens/auth/components/auth_field.dart';
import 'package:chatapp/screens/auth/components/primary_button.dart';
import 'package:chatapp/screens/profile/components/profile_image_view.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController? nameController;

  @override
  void dispose() {
    nameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState.currentUser == null) return Container();
            nameController ??=
                TextEditingController(text: authState.currentUser!.name);
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      ProfileImageView(
                        profileImage: authState.currentUser!.profileImage,
                      ),
                      const SizedBox(height: 30),
                      AuthField(
                        controller: nameController!,
                        hintText: 'Enter Name',
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Container()),
                          BlocBuilder<ProfileBloc, ProfileState>(
                            builder: (context, profileState) {
                              return Expanded(
                                flex: 4,
                                child: profileState.isLoading
                                    ? Center(child: circularProgress())
                                    : PrimaryButton(
                                        text: 'Update',
                                        onPressed: () {
                                          if (nameController!.text
                                              .trim()
                                              .isEmpty) {
                                            showSnackbar(
                                                SnackbarMessage.missing,
                                                'Please enter your name.');
                                          } else {
                                            context.read<ProfileBloc>().add(
                                                  UpdateProfileEvent(
                                                    name: nameController!.text
                                                        .trim(),
                                                    uid: authState
                                                        .currentUser!.uid,
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                              );
                            },
                          ),
                          Expanded(child: Container()),
                          Expanded(
                            flex: 4,
                            child: PrimaryButton(
                              color: Theme.of(context).colorScheme.secondary,
                              text: 'Log Out',
                              onPressed: () =>
                                  context.read<AuthBloc>().add(LogOutEvent()),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
