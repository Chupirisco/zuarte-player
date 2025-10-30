import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:zuarte/constants/icons.dart';
import 'package:zuarte/models/playlist_model.dart';
import 'package:zuarte/utils/build_image.dart';
import 'package:zuarte/utils/size_config.dart';
import 'package:zuarte/utils/style_configs.dart';
import 'package:zuarte/viewmodels/playlist_provider.dart';
import 'package:zuarte/widgets/buttton_component.dart';

class ModalEditPlaylist extends StatefulWidget {
  const ModalEditPlaylist({super.key, required this.playlistSelected});
  final PlaylistModel playlistSelected;
  @override
  State<ModalEditPlaylist> createState() => _ModalEditPlaylistState();
}

class _ModalEditPlaylistState extends State<ModalEditPlaylist> {
  TextEditingController controller = TextEditingController();
  Uri? _imagem;

  @override
  void initState() {
    super.initState();
    _imagem = widget.playlistSelected.artUri;
    controller.text = widget.playlistSelected.nome;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pegarImagemDaGaleria() async {
    final XFile? imagemSelecionada = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imagemSelecionada != null) {
      setState(() {
        _imagem = Uri.file(imagemSelecionada.path);
      });
    }
  }

  Future<void> _tirarFoto() async {
    final XFile? fotoTirada = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (fotoTirada != null) {
      setState(() {
        _imagem = Uri.file(fotoTirada.path);
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
        insetPadding: EdgeInsets.symmetric(horizontal: defaultMargin()),
        insetAnimationDuration: Duration(milliseconds: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //ações
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 22.sp),
                Text(
                  'Editar Playlist',
                  style: textStyle(
                    size: 16,
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
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
                  buildImage(theme.primaryContainer, _imagem, 50.sp, 50.sp),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonComponent(
                  surfaceColor: theme.primaryContainer,
                  onClick: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancelar',
                    style: textStyle(size: 16, color: theme.primary),
                  ),
                ),
                buttonComponent(
                  surfaceColor: theme.secondaryContainer.withAlpha(200),
                  onClick: () {
                    provPlay.editPlaylist(
                      widget.playlistSelected.id,
                      controller.text,
                      _imagem,
                    );
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
