import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class ImageUploadButton extends StatefulWidget {
  const ImageUploadButton(
      {Key? key, required this.preset, required this.setPictureUrl, required this.child})
      : super(key: key);

  final String preset;
  final Widget child;
  final dynamic setPictureUrl;

  @override
  State<ImageUploadButton> createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  String picture = '';
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    final cloudinary = CloudinaryPublic('firstlovecenter', widget.preset, cache: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: SizedBox(
            height: 200,
            child: picture != ''
                ? Image.network(
                    picture,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
                : progress > 0.0
                    ? const Center(child: Text('Uploading...'))
                    : const Center(child: Text('No Image to Show')),
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        progress > 0.0 && picture == ''
            ? LinearProgressIndicator(
                backgroundColor: const Color.fromARGB(255, 199, 180, 251).withOpacity(0.6),
                // value: progress,
              )
            : progress == 1.0
                ? const ElevatedButton(onPressed: null, child: Text('Upload Complete'))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final memberId =
                          AuthService.instance.idToken?.userId.replaceFirst('auth0|', '');
                      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      final authUser = AuthService.instance.idToken;
                      final date = DateTime.now().toIso8601String().split('T')[0];

                      try {
                        CloudinaryResponse response = await cloudinary.uploadFile(
                          CloudinaryFile.fromFile(
                            image?.path ?? '',
                            publicId:
                                'poimen/${authUser?.given_name}-${authUser?.family_name}-$memberId/${date}_${getRandomString(16)}',
                            identifier: 'user/user-$memberId',
                            tags: ['membership picture', 'face-detection'],
                            context: {
                              'caption': '_$memberId',
                              'uploader-id': memberId,
                              'uploader-name': '${authUser?.given_name} ${authUser?.family_name}',
                            },
                            resourceType: CloudinaryResourceType.Image,
                          ),
                          onProgress: (count, total) {
                            setState(() {
                              progress = count / total;
                            });
                          },
                        );

                        setState(() {
                          picture = response.secureUrl;
                        });
                        widget.setPictureUrl(response.secureUrl);
                      } on CloudinaryException catch (error) {
                        if (kDebugMode) {
                          print(error.message);
                          print(error.request);
                        }
                      }
                    },
                    child: widget.child,
                  )
      ],
    );
  }
}

getRandomString(int length) {
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}
