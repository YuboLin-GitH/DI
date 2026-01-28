import 'package:actividad_repaso_examen_eva2_6/viewmodels/GalleryViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'viewmodels/GalleryViewModel.dart';

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. 监听数据 (获取图片列表)
    final viewModel = context.watch<GalleryViewModel>();
    
    // 2. UI 逻辑 (自适应判断) - 放在这里是对的！
    // 考试要求：屏幕 > 600px 时显示 2 列，否则 1 列
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    final crossAxisCount = isWideScreen ? 2 : 1;

    return Scaffold(
      appBar: AppBar(title: Text('Galería MVVM')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // 使用计算好的列数
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          // 3. 使用 ViewModel 中的数据长度
          itemCount: viewModel.imageUrls.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                // 4. 使用 ViewModel 中的具体图片 URL
                child: Image.network(
                  viewModel.imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}