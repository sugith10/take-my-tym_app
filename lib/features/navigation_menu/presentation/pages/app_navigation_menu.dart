import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_my_tym/core/bloc/app_user_bloc/app_user_bloc.dart';
import 'package:take_my_tym/core/navigation/screen_transitions/no_movement.dart';
import 'package:take_my_tym/features/create_post/presentation/pages/create_post_first_page.dart';
import 'package:take_my_tym/features/home/presentation/pages/home_page.dart';
import 'package:take_my_tym/features/message/presentation/pages/chat_list_page.dart';
import 'package:take_my_tym/features/work/presentation/pages/control_panel_page.dart';
import 'package:take_my_tym/features/navigation_menu/presentation/bloc/navigation_bloc.dart';
import 'package:take_my_tym/features/navigation_menu/presentation/widgets/drawer/drawer_navigation_menu.dart';
import 'package:take_my_tym/features/profile/presentation/pages/profile_page.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  static route() => noMovement(const NavigationMenu());
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool pop = false;

  final _screen = [
    const HomePage(),
    const ChatListPage(),
    const CreatePostFirstPage(),
    const ControlPanelPage(),
    const ProfilePage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserBloc, AppState>(
      builder: (context, state) {
        if (state is UserModelUpdatedState) {
          return BlocProvider(
            create: (context) => NavigationBloc(),
            child: Scaffold(
              key: _scaffoldKey,
              drawer: const DrawerNavBar(),
              body: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  switch (state) {
                    case HomeState():
                      return SafeArea(child: _screen[0]);
                    case MessageState():
                      return SafeArea(child: _screen[1]);
                    case MoneyState():
                      return SafeArea(child: _screen[3]);
                    case ProfileState():
                      return SafeArea(child: _screen[4]);
                  }
                },
              ),
              bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
                  builder: (context, state) {
                return NavigationBar(
                  selectedIndex: _index,
                  onDestinationSelected: (value) {
                    final navigationBloc =
                        BlocProvider.of<NavigationBloc>(context);
                    switch (value) {
                      case 0:
                        _index = value;
                        navigationBloc.add(NavigationHomeEvent());
                        break;
                      case 1:
                        _index = value;
                        navigationBloc.add(MessagePageNavigation());
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          CreatePostFirstPage.route(),
                        );
                        break;
                      case 3:
                        _index = value;
                        navigationBloc.add(MoneyPageNavigation());
                        break;
                      case 4:
                        _index = value;
                        navigationBloc.add(ProfilePageNavigation());
                        break;
                    }
                  },
                  destinations: [
                    NavigationDestination(
                      icon: Icon(
                          _index == 0 ? IconlyBold.home : IconlyLight.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(
                        _index == 1 ? IconlyBold.message : IconlyLight.message,
                      ),
                      label: 'Message',
                    ),
                    NavigationDestination(
                      icon: Icon(
                        _index == 2 ? IconlyBold.plus : IconlyLight.plus,
                      ),
                      label: 'Create',
                    ),
                    NavigationDestination(
                      icon: Icon(
                        _index == 3 ? IconlyBold.work : IconlyLight.work,
                      ),
                      label: 'Work',
                    ),
                    NavigationDestination(
                      icon: Icon(
                        _index == 4 ? IconlyBold.profile : IconlyLight.profile,
                      ),
                      label: 'Profile',
                    ),
                  ],
                );
              }),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: Text("Something went wrong")),
        );
      },
    );
  }
}