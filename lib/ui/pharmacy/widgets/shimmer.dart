import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: ListView(
        children: List.generate(
            3,
                (index) => Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    //     baseColor: Colors.grey[300],
                    // highlightColor: Colors.grey[100],
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 220,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 60,
                                    height: 5,
                                    color: Colors.grey),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 60,
                                    height: 5,
                                    color: Colors.grey),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 60,
                                    height: 5,
                                    color: Colors.grey),
                                // Text("Full Name"),
                                // Text("role"),
                                // Text("16 hours ago")
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(width: 40, height: 5, color: Colors.grey),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.grey),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    width: 40,
                                    height: 5,
                                    color: Colors.grey),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 20,
                                    height: 20,
                                    color: Colors.grey),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    width: 40,
                                    height: 5,
                                    color: Colors.grey),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(thickness: 5),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thumb_up),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    width: 40,
                                    height: 5,
                                    color: Colors.grey),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        width: 40,
                                        height: 5,
                                        color: Colors.grey),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10)
              ],
            )),
      ),
    );
  }
}