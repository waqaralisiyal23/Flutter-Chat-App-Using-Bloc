import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const name = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
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
          floatingActionButton: homeState.selectedIndex == 0
              ? FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(
                    Icons.person_add_alt_1,
                    color: Colors.white,
                  ),
                )
              : null,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: homeState.selectedIndex,
            onTap: (newIndex) {
              context
                  .read<HomeBloc>()
                  .add(UpdateBottomBarIndex(newIndex: newIndex));
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.messenger), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: 'People'),
              BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.primaryColor,
                  backgroundImage: AssetImage(Images.profile),
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
