import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/utils/search_next_nam.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/viewmodels/audio_player_provider.dart';
import 'package:zuarte/viewmodels/playlist_provider.dart';
import 'package:zuarte/widgets/buttton_component.dart';
import 'package:zuarte/widgets/song_item_mark.dart';

class ModalCreatePlaylist extends StatefulWidget {
  const ModalCreatePlaylist({super.key});

  @override
  State<ModalCreatePlaylist> createState() => _ModalCreatePlaylistState();
}

class _ModalCreatePlaylistState extends State<ModalCreatePlaylist> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provPlay = context.read<PlaylistProvider>();

    int numName = searchNextName(provPlay);

    controller.text = 'Playlist N° $numName';
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  File? _imagem;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pegarImagemDaGaleria() async {
    final XFile? imagemSelecionada = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imagemSelecionada != null) {
      setState(() {
        _imagem = File(imagemSelecionada.path);
      });
    }
  }

  Future<void> _tirarFoto() async {
    final XFile? fotoTirada = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (fotoTirada != null) {
      setState(() {
        _imagem = File(fotoTirada.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provPlay = Provider.of<PlaylistProvider>(context);
    final ColorScheme theme = Theme.of(context).colorScheme;
    return MediaQuery.removeViewInsets(
      removeBottom: true,
      context: context,
      child: Dialog(
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
                SizedBox(width: 22.sp),
                Text(
                  'Criar Playlist',
                  style: textStyle(
                    size: 16,
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    provPlay.clearSongList();
                    Navigator.of(context).pop();
                  },

                  icon: Iconify(
                    AppIcons.close,
                    size: iconSize(20),
                    color: iconColor(theme),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 50.w,
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  buildImageWidget(_imagem, theme),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () => _pegarImagemDaGaleria(),
                      icon: Iconify(AppIcons.edit),
                    ),
                  ),
                ],
              ),
            ),

            //input
            SizedBox(
              width: 70.w,
              child: TextField(
                style: textStyle(
                  size: 16,
                  color: theme.primary,
                  fontWeight: FontWeight.bold,
                ),
                controller: controller,
                decoration: inputDecoration(theme),
              ),
            ),
            SizedBox(height: 2.h),

            Expanded(
              child: Consumer<SongProvider>(
                builder: (context, provSong, child) {
                  return ListView.builder(
                    physics: scrollEffect(),
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin()),
                    itemCount: provSong.songs.length,
                    itemBuilder: (context, index) {
                      final song = provSong.songs[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        child: SongItemMark(song: song),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonComponent(
                  surfaceColor: theme.primaryContainer,
                  onClick: () => {
                    provPlay.clearSongList(),
                    Navigator.of(context).pop(),
                  },
                  child: Text(
                    'Cancelar',
                    style: textStyle(size: 16, color: theme.primary),
                  ),
                ),
                buttonComponent(
                  surfaceColor: theme.secondaryContainer.withAlpha(200),
                  onClick: () {
                    provPlay.createPlaylist(controller.text, _imagem);
                    Navigator.of(context).pop();
                  },

                  child: Text(
                    'Salvar',
                    style: textStyle(size: 16, color: Color(0xFFF9F9F9)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}

InputDecoration inputDecoration(ColorScheme theme) {
  return InputDecoration(
    label: Text('Nome', style: textStyle(size: 14, color: theme.secondary)),
  );
}

Widget buildImageWidget(File? imagem, ColorScheme theme) {
  return ClipRRect(
    borderRadius: BorderRadiusGeometry.circular(defaultBorderRadius(18)),
    child: Container(
      height: 50.sp,
      width: 50.sp,
      color: theme.primaryContainer,

      child: imagem == null
          ? Iconify(AppIcons.person)
          : Image.file(imagem, fit: BoxFit.cover),
    ),
  );
}
