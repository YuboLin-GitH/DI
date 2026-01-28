import 'package:flutter/material.dart';

class GalleryViewModel extends ChangeNotifier {
  // 1. 数据 (Model): 图片链接列表
  final List<String> _imageUrls = [
    "https://placehold.co/300x300/FF0000/FFFFFF.jpg?text=1",
    "https://placehold.co/300x300/00FF00/FFFFFF.jpg?text=2",
    "https://placehold.co/300x300/0000FF/FFFFFF.jpg?text=3",
    "https://placehold.co/300x300/FFFF00/000000.jpg?text=4",
    "https://placehold.co/300x300/FF00FF/FFFFFF.jpg?text=5",
    "https://placehold.co/300x300/00FFFF/000000.jpg?text=6",
  ];

  // 2. 暴露数据
  List<String> get imageUrls => _imageUrls;

  // (如果是真实应用，这里会有 fetchImages() 方法)
}