import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:zuarte/constants/colors.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool verificacaoFutura = true;
    final double height = overallHeight();
    teste() {
      setState(() {
        verificacaoFutura = !verificacaoFutura;
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
      child: Column(
        children: [
          SizedBox(height: height * 0.01),
          Text(
            'Minhas músicas',
            style: textStyle(
              size: 18,
              color: LightColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.01),
          verificacaoFutura
              ? Expanded(
                  child: ScrollablePositionedList.builder(
                    physics: scrollEffect(),
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: true,
                    minCacheExtent: 50,
                    padding: EdgeInsets.zero,
                    itemCount: 100,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      decoration: BoxDecoration(
                        color: LightColors.cardElements,
                        borderRadius: BorderRadius.circular(
                          defaultBorderRadius(20),
                        ),
                      ),
                      child: ListTile(
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
                      color: LightColors.secondaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
