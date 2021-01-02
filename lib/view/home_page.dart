import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tales/modelview/tale_model_view.dart';

class HomePage extends StatefulWidget {
  HomePage(Key k) : super(key: k);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List talesList = [];

  @override
  void initState() {
    super.initState();
    setTales();
  }

  setTales() {
    talesList =
        Provider.of<TaleModelView>(context, listen: false).getAllTales();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 3, child: showPopularTale()),
        Expanded(flex: 5, child: showAllTale()),
      ],
    );
  }

  showPopularTale() => Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: showPopularTaleHeader(),
            ),
            Expanded(
              flex: 7,
              child: showPopularTaleBody(),
            ),
          ],
        ),
      );

  showPopularTaleHeader() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Yeni Masallar",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            InkWell(
              onTap: () {
                Fluttertoast.showToast(
                  msg: "Şimdilik hepsi bu",
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  "Tümümü Gör",
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
            ),
          ],
        ),
      );

  showPopularTaleBody() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/playerPage',
                  arguments: talesList[index]),
              child: Container(
                height: ScreenUtil().screenWidth * 0.3,
                width: ScreenUtil().screenWidth * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: showPopularTaleBodyCover(index),
                    ),
                    Expanded(
                      flex: 2,
                      child: showPopularTaleBodyInformation(index),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  showPopularTaleBodyCover(int index) => Material(
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          talesList[index].taleProfileUrl,
          fit: BoxFit.cover,
        ),
      );

  showPopularTaleBodyInformation(int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            talesList[index].taleName,
            style: Theme.of(context).textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          AutoSizeText(
            talesList[index].voicingName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      );

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  showAllTale() => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: showAllTaleHeader(),
            ),
            Expanded(
              flex: 7,
              child: showAllTaleBody(),
            ),
          ],
        ),
      );

  showAllTaleHeader() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tüm Masallar",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            InkWell(
              onTap: () {
                Fluttertoast.showToast(
                  msg: "Şimdilik hepsi bu",
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  "Tümümü Gör",
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
            ),
          ],
        ),
      );

  showAllTaleBody() => Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 16, right: 16),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.pushNamed(context, '/playerPage',
                  arguments: talesList[index]),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showAllTaleBodyImageAndInformation(index),
                      showAllTaleBodyPlayButton(index)
                    ],
                  )),
            );
          },
        ),
      );

  showAllTaleBodyImageAndInformation(int index) => Row(
        children: [
          CircleAvatar(
              radius: 28.h,
              backgroundImage: AssetImage(talesList[index].taleProfileUrl)),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                talesList[index].taleName,
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              AutoSizeText(
                talesList[index].voicingName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          )
        ],
      );

  showAllTaleBodyPlayButton(index) => Container();
}
