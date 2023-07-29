class ImageRes {
  ImageRes._shared();
  static final ImageRes _instance = ImageRes._shared();

  factory ImageRes() => _instance;

  static const String _imageBase = 'assets/images';
  static const String logo = '$_imageBase/todo.png';
}
