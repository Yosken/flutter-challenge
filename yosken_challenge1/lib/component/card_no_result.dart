import 'package:flutter/material.dart';

Widget makeNoResultCard() => Stack(children: [
  Center(
          child: SizedBox(
              height: 100,
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.black,
                  disabledForegroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: null,
                child: const Text(
                  '充電スポットが見つかりません。\nエリアを変えてお試しください。',
                  style: TextStyle(fontSize: 20, ),
                ),
              ))),
      Container()
    ]);
