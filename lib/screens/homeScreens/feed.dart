import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:majles_app/cubit/cubit.dart';
import 'package:majles_app/cubit/state.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHome, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              shrinkWrap: true,
              reverse: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (CubitHome.get(context).posts[index]["text"] != '' ||
                    CubitHome.get(context).posts[index]["image"] != '') {
                  return AnimatedListItem(CubitHome.get(context).posts[index]);
                } else {
                  return SizedBox();
                }
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: CubitHome.get(context).posts.length),
        );
      },
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final index;

  AnimatedListItem(this.index);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(microseconds: 100 * 100), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        duration: Duration(milliseconds: 1000),
        opacity: _animate ? 1 : 0,
        curve: Curves.easeInOutBack,
        child: AnimatedPadding(
          duration: Duration(milliseconds: 1000),
          padding: _animate
              ? const EdgeInsets.all(4.0)
              : const EdgeInsets.only(top: 10),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.white,
            elevation: 2.5,
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://cdnjobs.net/cached_uploads/fit/650/315/2020/02/17/%D8%B4%D8%B9%D8%A7%D8%B1-%D8%A7%D9%84%D9%83%D9%84%D9%8A%D8%A9-1581953753.png"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Majless",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 16,
                                )
                              ],
                            ),
                            Text(
                              Jiffy(widget.index["dateTime"]).fromNow(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Text(widget.index["text"],
                      style: Theme.of(context).textTheme.bodyText1),
                  widget.index["image"] != ''
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                  image: NetworkImage(widget.index["image"]),
                                  fit: BoxFit.contain,
                                ),
                              )),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
