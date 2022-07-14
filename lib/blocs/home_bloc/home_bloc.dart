import 'package:chatapp/screens/chat/chat_list_screen.dart';
import 'package:chatapp/screens/find_people/people_list_screen.dart';
import 'package:chatapp/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<Map<String, dynamic>> screenDetails = [
    {'title': 'Chats', 'screen': const ChatListScreen()},
    {'title': 'Find People', 'screen': const PeopleListScreen()},
    {'title': 'Calls', 'screen': const Center(child: Text('Calls'))},
    {'title': 'Profile', 'screen': const ProfileScreen()},
  ];

  HomeBloc()
      : super(
          const HomeState(
            selectedIndex: 0,
            title: 'Chats',
            screen: ChatListScreen(),
          ),
        ) {
    on<UpdateBottomBarIndex>((event, emit) {
      emit(
        HomeState(
          selectedIndex: event.newIndex,
          title: screenDetails[event.newIndex]['title'],
          screen: screenDetails[event.newIndex]['screen'],
        ),
      );
    });
  }
}
