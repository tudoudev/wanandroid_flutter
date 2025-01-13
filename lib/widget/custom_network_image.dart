import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 显示来自互联网的图像并将它们保存在缓存目录中
class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const CustomNetworkImage({super.key, required this.imageUrl, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
            fit: fit,
            imageUrl: imageUrl,
            placeholder: (context, url) => Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : Container();
  }
}
