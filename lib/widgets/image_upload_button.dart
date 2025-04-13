import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/theme.dart';

class ImageUploadButton extends StatefulWidget {
  const ImageUploadButton({
    Key? key,
    required this.preset,
    required this.setPictureUrl,
    required this.child,
    this.initialImageUrl,
  }) : super(key: key);

  final String preset;
  final Widget child;
  final Function(String) setPictureUrl;
  final String? initialImageUrl;

  @override
  State<ImageUploadButton> createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  String picture = '';
  double progress = 0.0;
  bool isUploading = false;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Initialize picture state with initialImageUrl if provided
    if (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty) {
      setState(() {
        picture = widget.initialImageUrl!;
      });
    }
  }

  Future<void> _uploadImage() async {
    setState(() {
      isUploading = true;
      progress = 0.01; // Show initial progress
      hasError = false;
      errorMessage = '';
    });

    final ImagePicker picker = ImagePicker();

    try {
      final XFile? imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Optimize image quality
      );

      if (imageFile == null) {
        // User canceled the picker
        setState(() {
          isUploading = false;
          progress = 0.0;
        });
        return;
      }

      // Get user info from AuthService with proper null handling
      final authUser = AuthService.instance.profile;

      if (authUser == null) {
        setState(() {
          isUploading = false;
          hasError = true;
          errorMessage = 'User not authenticated. Please log in and try again.';
        });
        return;
      }

      // Extract user ID from sub field (remove auth0| prefix if present)
      final memberId = authUser.sub.startsWith('auth0|')
          ? authUser.sub.replaceFirst('auth0|', '')
          : authUser.sub;

      // Format date for folder structure
      final date = DateTime.now().toIso8601String().split('T')[0];

      // Extract names with proper null handling
      final nameParts = authUser.name.split(' ');
      final firstName = nameParts.isNotEmpty ? nameParts[0].toLowerCase() : 'unknown';
      final lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

      // Initialize Cloudinary with the preset
      final cloudinary = CloudinaryPublic('firstlovecenter', widget.preset, cache: false);

      // Create a unique public ID for the image
      final publicId = 'poimen/$firstName-$lastName-$memberId/${date}_${getRandomString(16)}';

      // Upload the image
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          publicId: publicId,
          tags: ['membership picture', 'face-detection'],
          context: {
            'caption': '_$memberId',
            'uploader-id': memberId,
            'uploader-name': authUser.name,
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
        isUploading = false;
        progress = 1.0;
      });

      // Call the callback function to update the parent widget
      widget.setPictureUrl(response.secureUrl);
    } catch (error) {
      if (kDebugMode) {
        print('Error uploading image: $error');
      }

      setState(() {
        isUploading = false;
        hasError = true;
        errorMessage = 'Failed to upload image. Please try again.';
        progress = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the initialImageUrl as fallback if picture is empty but initialImageUrl exists
    final displayImageUrl = picture.isNotEmpty
        ? picture
        : (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty
            ? widget.initialImageUrl!
            : '');

    final hasImage = displayImageUrl.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Image preview card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: hasError ? Colors.red.shade300 : Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: hasImage
                  ? Image.network(
                      displayImageUrl,
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
                            color: PoimenTheme.brand,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.broken_image, size: 40, color: Colors.red.shade300),
                              const SizedBox(height: 8),
                              const Text('Failed to load image',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        );
                      },
                    )
                  : isUploading
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: progress > 0 ? progress : null,
                                color: PoimenTheme.brand,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Uploading... ${(progress * 100).toInt()}%',
                                style: TextStyle(color: PoimenTheme.brand),
                              ),
                            ],
                          ),
                        )
                      : hasError
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline, size: 40, color: Colors.red.shade400),
                                  const SizedBox(height: 8),
                                  Text(
                                    errorMessage,
                                    style: TextStyle(color: Colors.red.shade400),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 48,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No Image Selected',
                                    style: TextStyle(color: Colors.grey.shade600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Click the button below to upload',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
            ),
          ),
        ),

        const Padding(padding: EdgeInsets.all(8.0)),

        // Upload button or progress indicator
        if (isUploading)
          LinearProgressIndicator(
            value: progress > 0 ? progress : null,
            backgroundColor: PoimenTheme.brand.withOpacity(0.2),
            color: PoimenTheme.brand,
          )
        else if (progress == 1.0 && !hasError)
          ElevatedButton.icon(
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Upload Complete'),
            onPressed: _uploadImage, // Allow re-upload if needed
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          )
        else
          ElevatedButton.icon(
            icon: Icon(hasError ? Icons.refresh : Icons.add_photo_alternate),
            label: Text(hasError ? 'Try Again' : (hasImage ? 'Change Image' : 'Select Image')),
            onPressed: _uploadImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: PoimenTheme.brand,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          )
      ],
    );
  }
}

String getRandomString(int length) {
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}
