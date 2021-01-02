import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tales/model/tale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tales/modelview/tale_model_view.dart';

class SearchPage extends StatefulWidget {
  SearchPage(Key k) : super(key: k);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchTextController;
  List<Tale> foundTalesList = [];

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TaleModelView>(context, listen: true);
    return Column(
      children: [
        searchBar(),
        foundTalesListField(),
      ],
    );
  }

  searchBar() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: TextFormField(
          controller: searchTextController,
          onChanged: (c) {
            searchTale(c);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).canvasColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).canvasColor,
                width: 1.0,
              ),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).accentColor.withOpacity(0.5),
            ),
            fillColor: Theme.of(context).canvasColor,
          ),
        ),
      );

  void searchTale(String text) {
    foundTalesList.clear();
    foundTalesList = Provider.of<TaleModelView>(context, listen: false)
        .searchTaleWithName(text);
  }

  foundTalesListField() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: foundTalesList.length,
              itemBuilder: (context, index) => oneTaleElement(index)),
        ),
      );

  oneTaleElement(int index) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed('/playerPage', arguments: foundTalesList[index]),
          child: Container(
              /*   color: Theme.of(context).canvasColor, */
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 28.h,
                          backgroundImage:
                              AssetImage(foundTalesList[index].taleProfileUrl)),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            foundTalesList[index].taleName,
                            style: Theme.of(context).textTheme.bodyText2,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          AutoSizeText(
                            foundTalesList[index].voicingName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ),
      );
}
