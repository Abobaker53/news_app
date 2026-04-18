import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:news/Screens/widgets/News_Card.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Models/Article_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Article> newsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchingData();
  }

  Future<void> fetchingData() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://newsapi.org/v2/everything?q=sport&sortBy=publishedAt&apiKey=67b473651e1743328ff1bc61e8323fcb",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          newsList = (data["articles"] as List)
              .map((e) => Article.fromJson(e))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Cannot open link")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : newsList.isEmpty
              ? const Center(child: Text("No News Found"))
              : RefreshIndicator(
            onRefresh: fetchingData,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icon.svg"),
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(Icons.logout),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      return NewsCard(article: newsList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
