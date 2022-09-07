class CloudinaryImage {
  String _imageUrl = '';
  ImageSize _size = ImageSize.normal;

  CloudinaryImage({String url = '', ImageSize size = ImageSize.normal}) {
    _imageUrl = url;
    if (url == '') {
      _imageUrl =
          'https://res.cloudinary.com/firstlovecenter/image/upload/v1627893621/user_qvwhs7.png';
    }
    _size = size;
  }

  String get imageUrl => _transformImage(_imageUrl, _size);

  set imageUrl(
    String imageUrl,
  ) {
    _imageUrl = imageUrl;
  }

  set size(ImageSize size) {
    _size = size;
  }
}

String _transformImage(String url, ImageSize size) {
  if (size == ImageSize.lg) {
    return url.replaceFirst('upload/', 'upload/c_fill,g_face,h_300,w_300/');
  }

  return url.replaceFirst('upload/', 'upload/c_thumb,g_face,h_150,w_150,z_0.7/');
}

enum ImageSize { normal, lg }
