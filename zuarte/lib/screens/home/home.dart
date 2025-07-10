import 'package:flutter/material.dart';
import 'package:zuarte/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      itemCount: 1,
      itemBuilder: (context, index) => ListTile(
        leading: Text('capa'),
        title: Text('Nome'),
        subtitle: Text('Cantor'),
        trailing: Text('Função'),
        onTap: () {},
      ),
    );
  }
}
