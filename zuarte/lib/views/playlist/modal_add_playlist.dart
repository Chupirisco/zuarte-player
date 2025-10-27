import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/viewmodels/playlist_provider.dart';
import 'package:zuarte/widgets/buttton_component.dart';

class ModalAddPlaylist extends StatefulWidget {
  const ModalAddPlaylist({super.key});

  @override
  State<ModalAddPlaylist> createState() => _ModalAddPlaylistState();
}

class _ModalAddPlaylistState extends State<ModalAddPlaylist> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final numPlay = context.read<PlaylistProvider>().playlists.length + 1;
    controller.text = 'Playlist N° ${numPlay}';
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provPlay = Provider.of<PlaylistProvider>(context);
    final ColorScheme theme = Theme.of(context).colorScheme;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: defaultMargin(),
        vertical: defaultMargin(),
      ),
      insetAnimationDuration: Duration(milliseconds: 300),
      child: Column(
        children: [
          //ações
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20.sp),
              Text(
                'Criar Playlist',
                style: textStyle(
                  size: 16,
                  color: theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                onPressed: () => Navigator.of(context).pop(),

                icon: Iconify(
                  AppIcons.close,
                  size: iconSize(20),
                  color: iconColor(theme),
                ),
              ),
            ],
          ),

          //input
          SizedBox(
            width: 70.w,
            child: TextField(
              controller: controller,
              decoration: inputDecoration(theme),
            ),
          ),

          Expanded(child: ListView()),
          Row(
            children: [
              buttonComponent(
                onClick: () => controller.clear(),

                child: Text('Cancelar'),
              ),
              buttonComponent(
                onClick: () {
                  provPlay.createPlaylist(controller.text, null);
                  Navigator.of(context).pop();
                },

                child: Text('Salvar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

InputDecoration inputDecoration(ColorScheme theme) {
  return InputDecoration(
    label: Text('Nome', style: textStyle(size: 14, color: theme.secondary)),
  );
}
