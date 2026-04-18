import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/Article_model.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({super.key, required this.article});

  Future<void> openLink(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot open link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.image ?? "",
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 200,
                    width: 400,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              article.title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              article.author ?? "Unknown Author",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(article.description ?? "No Description"),
            const SizedBox(height: 8),
            Text(
              article.date,
              style: const TextStyle(color: Colors.black54),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Share.share("${article.title}\n${article.url}");
                  },
                  icon: const Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () {
                    openLink(context, article.url);
                  },
                  icon: const Icon(Icons.open_in_browser),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}