import 'package:flutter/material.dart';
import 'package:quantam/News/Presentation/Widgets/news_Card.dart';
import '../../Repository/news_repository.dart';

class NoInternetNewsScreen extends StatefulWidget {
  const NoInternetNewsScreen({super.key});

  @override
  State<NoInternetNewsScreen> createState() => _NoInternetNewsScreenState();
}

class _NoInternetNewsScreenState extends State<NoInternetNewsScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: NewsRepository().buildFromLocalData(),
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.hasError
                ? const Center(child: Text("No data"))
                : ListView.builder(
                    itemCount: 20,
                    itemBuilder: ((context, index) {
                      return NewsCard(snapshot.data!.articles![index], width);
                    }))
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
