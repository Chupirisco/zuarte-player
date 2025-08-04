import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/viewmodels/list_songs_provider.dart';
import 'package:zuarte/widgets/cards.dart';

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
    final provider = Provider.of<ListSongsProvider>(context);
    bool verificacaoFutura = true;
    final ColorScheme theme = Theme.of(context).colorScheme;
    // ignore: unused_element
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
          provider.listSongs.isNotEmpty
              ? Expanded(
                  child: ScrollablePositionedList.builder(
                    physics: scrollEffect(),
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    minCacheExtent: 50,
                    padding: EdgeInsets.zero,
                    itemCount: provider.listSongs.length,
                    itemBuilder: (context, index) => musicCard(
                      context: context,
                      theme: theme,
                      onOptions: true,
                      music: provider.listSongs[index],
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
