import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:api_ecommerce_app/app/utils/helper/api_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool isDrooped = false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'K_Store',
              textStyle: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 1000),
            ),
          ],
          displayFullTextOnTap: true,
          repeatForever: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'Cart');
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
        foregroundColor: Colors.white,
        focusColor: Colors.white12,
      ),
      body: FutureBuilder(
        future: ecom_helper.api.getdata(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            log("${snapshot.data}");
            return ListView.builder(
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Draggable(
                      data: "drag",
                      childWhenDragging: Container(
                        height: 400,
                        width: 400,
                      ),
                      feedback: Container(
                        margin: EdgeInsets.all(50),
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${snapshot.data![i].image}"),
                          ),
                        ),
                      ),
                      child: (isDrooped)
                          ? Container()
                          : Container(
                              margin: EdgeInsets.all(50),
                              height: 400,
                              width: 400,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${snapshot.data![i].image}"),
                                ),
                              ),
                            ),
                    ),
                    DragTarget(
                      builder: (ctx, _, __) {
                        return (isDrooped)
                            ? Container(
                                height: 400,
                                width: 400,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${snapshot.data![i].image}"),
                                  ),
                                ),
                              )
                            : Container();
                      },
                      onWillAccept: (data) {
                        return data == 'drag';
                      },
                      onAccept: (data) {
                        setState(() {
                          isDrooped = true;
                        });
                      },
                    ),
                    Center(
                      child: Text(
                        "${snapshot.data![i].title}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
                //   ListTile(
                //   trailing: Image.network("${snapshot.data![i].image}"),
                //   title: Text("${snapshot.data![i].title}"),
                // );
              },
              itemCount: snapshot.data!.length,
              // itemExtent: 1,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
