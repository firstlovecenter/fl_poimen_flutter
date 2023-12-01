import 'package:cached_network_image/cached_network_image.dart';

class CloudinaryImage {
  String _url = '';
  ImageSize _size = ImageSize.normal;

  CloudinaryImage({String url = '', ImageSize size = ImageSize.normal}) {
    _url = url;

    if (url == '') {
      _url = 'https://res.cloudinary.com/firstlovecenter/image/upload/v1627893621/user_qvwhs7.png';
    }
    _size = size;
  }

  String get url => _transformImage(_url, _size);

  CachedNetworkImageProvider get image => CachedNetworkImageProvider(_transformImage(_url, _size));

  set url(String url) {
    _url = url;
  }

  set size(ImageSize size) {
    _size = size;
  }
}

String _transformImage(String url, ImageSize size) {
  String jpegUrl = url.replaceAll('.png', '.jpg');

  if (size == ImageSize.fixedHeight) {
    return jpegUrl.replaceFirst('upload/', 'upload/c_fill,g_face,h_500/');
  }
  if (size == ImageSize.h250) {
    return jpegUrl.replaceFirst('upload/', 'upload/c_fill,g_face,h_250/');
  }
  if (size == ImageSize.widescreen) {
    return jpegUrl.replaceFirst('upload/', 'upload/ar_16:9,c_fill,g_face,h_250/');
  }

  if (size == ImageSize.lg) {
    return jpegUrl.replaceFirst('upload/', 'upload/c_fill,g_face,h_300,w_300,z_0.7/');
  }

  if (size == ImageSize.sm) {
    return jpegUrl.replaceFirst('upload/', 'upload/c_thumb,g_face,h_70,w_70,z_0.7/');
  }

  if (size == ImageSize.xs) {
    return jpegUrl.replaceFirst('upload/', 'upload/c_thumb,g_face,h_70,w_70,z_0.7/');
  }

  return jpegUrl.replaceFirst('upload/', 'upload/c_thumb,g_face,h_150,w_150,z_0.7/');
}

enum ImageSize { normal, lg, sm, xs, fixedHeight, h250, widescreen }
