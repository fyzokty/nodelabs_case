import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth_bloc.dart';
import '../add_photo.dart';

mixin AddPhotoScreenMixin on State<AddPhotoScreen> {
  ValueNotifier<String?> imagePath = ValueNotifier<String?>(null);

  final _picker = ImagePicker();

  Future<void> pickImageOnTap() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    log(imagePath.value.toString());
    imagePath.value = image.path;
  }

  void uploadOnTap() {
    if (imagePath.value == null) return;
    context.read<AuthBloc>().add(AuthUploadPhoto(imagePath: imagePath.value!));
  }
}
