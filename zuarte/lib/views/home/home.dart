import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

import '../../utils/size_config.dart';
import '../../utils/style_configs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final height = 100.h;
  @override
  Widget build(BuildContext context) {
    bool verificacaoFutura = true;
    final ColorScheme theme = Theme.of(context).colorScheme;
    teste() {
      setState(() {
        verificacaoFutura = !verificacaoFutura;
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      child: Column(
        children: [
          SizedBox(height: height * 0.02),
          Text(
            'Minhas músicas',
            style: textStyle(
              size: 18,
              color: theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.02),
          verificacaoFutura
              ? Expanded(
                  child: ScrollablePositionedList.builder(
                    physics: scrollEffect(),
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    minCacheExtent: 50,
                    padding: EdgeInsets.zero,
                    itemCount: 2,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: height * 0.01),
                      child: ListTile(
                        tileColor: theme.primaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(20),
                        ),
                        leading: Text('capa'),
                        title: Text('Nome'),
                        subtitle: Text('Cantor'),
                        trailing: Text('Função'),
                        onTap: () {
                          teste();
                        },
                      ),
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Nenhuma música por aqui',
                    style: textStyle(
                      size: 15,
                      color: theme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
