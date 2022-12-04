import 'package:flutter/material.dart';
import 'package:quantam/News/Presentation/Widgets/news_Card.dart';
import 'package:quantam/News/Repository/news_repository.dart';
import 'package:quantam/News/utils/colorPallete.dart';

class TopHeadLinesScreen extends StatefulWidget {
  const TopHeadLinesScreen({Key? key}) : super(key: key);

  @override
  State<TopHeadLinesScreen> createState() => _TopHeadLinesScreenState();
}

TextEditingController searchController = TextEditingController();

class _TopHeadLinesScreenState extends State<TopHeadLinesScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: NewsRepository().getTopHeadlines(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: 20,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = snapshot.data.articles[index];
                    return NewsCard(data, width * 0.4);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
