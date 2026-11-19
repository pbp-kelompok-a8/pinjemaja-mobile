import 'package:flutter/material.dart';
import 'main.dart';
import 'package:pinjem_aja_mobile/features/transaction/screens/transaction_list_screen.dart';
import 'package:pinjem_aja_mobile/features/search/screens/search_screen.dart';
import 'package:pinjem_aja_mobile/features/profile/screens/profile_screen.dart';
import 'package:pinjem_aja_mobile/features/chat/screens/chat_screen.dart';
import 'package:pinjem_aja_mobile/features/item/screens/item_list_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  final List<Widget> _pages = const [
    ItemListScreen(title: 'Item',    icon: Icons.inventory_2_outlined),
    SearchScreen(title: 'Search',      icon: Icons.search),
    TransactionListScreen(title: 'Transaction', icon: Icons.swap_horiz),
    ChatScreen(title: 'Chat',      icon: Icons.chat_bubble_outline),
    ProfileScreen(title: 'Profile',    icon: Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: _pages[_index],

      // navigation bar bawah
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Item',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Transaction',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ]
      )
    );
  }
}
