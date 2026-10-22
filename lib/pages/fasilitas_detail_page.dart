import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class FasilitasDetailPage extends StatelessWidget {
  final String title;
  final String desc;
  final String imageUrl;
  final List<String> details;

  const FasilitasDetailPage({
    super.key,
    required this.title,
    required this.desc,
    required this.imageUrl,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 250,
                color: AppColors.polmanSilver,
                child: const Icon(Icons.image_not_supported, size: 64, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.polmanBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(desc, style: const TextStyle(color: AppColors.textPrimary)),
                  const SizedBox(height: 20),
                  const Text(
                    'Detail Fasilitas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.polmanBlue,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  ...details.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle, color: AppColors.polmanBlue, size: 20),
                          const SizedBox(width: 10),
                          Expanded(child: Text(item)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
