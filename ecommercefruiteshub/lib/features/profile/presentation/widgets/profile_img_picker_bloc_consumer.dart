import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_user.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_network_image.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_progress_hud.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/cubit/cubit/main_profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileImgPickerBlocConsumer extends StatelessWidget {
  const ProfileImgPickerBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CircleAvatar(
          radius: 50,
          child: BlocConsumer<MainProfileCubit, MainProfileState>(
            listenWhen: (previous, current) =>
                current is LoadingImgStart ||
                current is LoadingImgError ||
                current is LoadingImgSUccess ||
                current is SaveProfilPIctureUrlSuccess,

            listener: (context, state) {
              if (state is LoadingImgError) {
                showBar(context, state.message);
              }
              if (state is LoadingImgSUccess) {
                showBar(context, "Image_uploaded_successfully".tr());
              }
            },
            bloc: BlocProvider.of<MainProfileCubit>(context),
            buildWhen: (previous, current) =>
                current is LoadingImgStart ||
                current is LoadingImgError ||
                current is LoadingImgSUccess,
            builder: (context, state) {
              return CustomProgressHud(
                isLoading: state is LoadingImgStart,
                child: CustomNetworkImage(
                  imageUrl: state is LoadingImgSUccess
                      ? state.imageUrl
                      : getUser().profilePicture!,
                ),
              );
            },
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () => _pickImage(context: context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.green,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage({required BuildContext context}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      context.read<MainProfileCubit>().uploadImage(
        fileToUpload: File(pickedFile.path),
        fileName: pickedFile.name,
      );
      // setState(() {
      //   _imageFile = File(pickedFile.path);
      // });
    }
  }
}
