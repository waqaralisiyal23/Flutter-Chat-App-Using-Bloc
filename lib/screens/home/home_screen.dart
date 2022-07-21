import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/helpers/local_storage.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/home/controllers/home_controller.dart';
import 'package:chatapp/services/user_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const name = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    HomeController.refereshCurrentUser(context);
    updateOnlineStatus(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        updateOnlineStatus(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        updateOnlineStatus(false);
        break;
    }
  }

  void updateOnlineStatus(bool isOnline) async {
    try {
      await UserService.updateProifle(
        uid: LocalStorage.readUser().uid,
        dataToUpdate: {'status': isOnline},
      );
    } catch (e) {
      // error
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(homeState.title),
              actions: [
                if (homeState.selectedIndex == 1)
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
              ],
            ),
            body: homeState.screen,
            floatingActionButton: homeState.selectedIndex == 1
                ? FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: AppColors.primaryColor,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                : null,
            bottomNavigationBar: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                if (authState.currentUser == null) return Container();
                return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: homeState.selectedIndex,
                  onTap: (newIndex) {
                    context
                        .read<HomeBloc>()
                        .add(UpdateBottomBarIndex(newIndex: newIndex));
                  },
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.messenger), label: 'Chats'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.people), label: 'People'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.call), label: 'Calls'),
                    BottomNavigationBarItem(
                      icon: CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.primaryColor,
                        backgroundImage: authState.currentUser!.profileImage ==
                                null
                            ? const AssetImage(Images.profile)
                            : NetworkImage(authState.currentUser!.profileImage!)
                                as ImageProvider,
                      ),
                      label: 'Profile',
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
