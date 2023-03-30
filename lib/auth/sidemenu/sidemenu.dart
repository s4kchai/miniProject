import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) =>Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue[100],

      ),
      drawer: const NavigationDrawer(),
  );
    

}

  class NavigationDrawer extends StatelessWidget {
    const NavigationDrawer({Key? key}) : super(key:key);
    @override
    Widget build(BuildContext context)=> Drawer();
  }