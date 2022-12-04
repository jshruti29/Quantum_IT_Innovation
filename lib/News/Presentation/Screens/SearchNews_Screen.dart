import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quantam/News/Presentation/Widgets/news_Card.dart';
import 'package:quantam/News/Repository/news_repository.dart';
import 'package:quantam/News/utils/strings.dart';
import 'package:quantam/signin.dart';

import 'TopHeadlines_Screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'no_internet_news_screen.dart';

class SearchNewsScreen extends StatefulWidget {
  const SearchNewsScreen({Key? key}) : super(key: key);

  @override
  State<SearchNewsScreen> createState() => _SearchNewsScreenState();
}

TextEditingController searchController = TextEditingController();

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          GoogleSignIn googleSignIn = GoogleSignIn();
          FirebaseAuth.instance.currentUser!.emailVerified != false
              ? await googleSignIn.disconnect()
              : null;

          await FirebaseAuth.instance.signOut();
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SignIN()),
              (route) => false);
        },
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.logout),
        label: const Text('LOGOUT'),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        bottom: PreferredSize(
          preferredSize: const Size(50, 50),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 25.0, // soften the shadow
                  spreadRadius: 10, //extend the shadow
                  offset: const Offset(10, 0 // Move to bottom 10 Vertically
                      ),
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: const Text(StringFiles.searchLabel),
                  border: InputBorder.none),
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: _connectionStatus != ConnectivityResult.none
                  ? searchController.text.isNotEmpty
                      ? FutureBuilder(
                          future: NewsRepository()
                              .getAllNews(searchController.text.toString()),
                          builder: (context, AsyncSnapshot snapshot) {
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
                        )
                      : const TopHeadLinesScreen()
                  : const NoInternetNewsScreen())
        ],
      ),
    );
  }
}
