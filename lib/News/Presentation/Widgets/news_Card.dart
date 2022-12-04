// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:quantam/News/Models/News.dart';
import 'package:quantam/News/utils/app_constants.dart';
import 'package:quantam/colors.dart';

Widget NewsCard(Articles data, double width) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      // height: 180,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 5.0,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.grey),
                          text: data.publishedAt.toString().substring(0, 10),
                          children: [
                        TextSpan(
                          text: "  ${data.source!.name}",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500),
                        )
                      ])),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: newsTextColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.description.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: newsTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(14),
                child: Image.network(
                  height: 70,
                  width: 70,
                  data.urlToImage.toString(),
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset(AppConstants.errorImage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
