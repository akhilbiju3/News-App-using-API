import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:newsapp/controller/category_controller/categrory_controller.dart';
import 'package:newsapp/global_widgets/constants/color_constants/color.dart';
import 'package:newsapp/model/list_items/list.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  final int categoryIndex;
  final String categoryName;
  const CategoryDetails(
      {super.key, required this.categoryIndex, required this.categoryName});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void didChangeDependencies() {
    categoryFetchData();
    super.didChangeDependencies();
  }

  void categoryFetchData() async {
    final categoryScreenProviders =
        Provider.of<CategoryController>(context, listen: true);

    try {
      await categoryScreenProviders.categoryData(
          categoryQuery: widget.categoryName);
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var categoryScreenProvider = Provider.of<CategoryController>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(ListItems.gridList[widget.categoryIndex],style: TextStyle(color: Color(0xff7C040D)),),
        centerTitle: true,
      ),
      body: categoryScreenProvider.isLoading
          ? Center(child: LoadingAnimationWidget.inkDrop(
                    color: Color(0xff7C040D), size: 30))
          : RefreshIndicator(
              onRefresh: () {
                return Future.wait([
                  categoryScreenProvider.categoryData(
                      categoryQuery: widget.categoryName),
                ]);
              },
              child: Consumer<CategoryController>(
                builder: (context, categoryProvider, child) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    itemCount: categoryScreenProvider
                            .categoryResponse?.sources?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:backgroundColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white.withOpacity(.89),
                                        ),
                                        child: Icon(Icons.share)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white.withOpacity(.89),
                                        ),
                                        child: Icon(Icons.bookmark_border)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categoryScreenProvider.categoryResponse
                                                ?.sources?[index].name ??
                                            "No Data",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Text(
                                              categoryScreenProvider
                                                      .categoryResponse
                                                      ?.sources?[index]
                                                      .description ??
                                                  "No Data",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 2,
                                        indent: 0,
                                      ),
                                      Text(
                                        categoryScreenProvider.categoryResponse
                                                ?.sources?[index].url ??
                                            "No Data",
                                        style: TextStyle(
                                            fontSize: 16,
                                            height: 1.5,
                                            overflow: TextOverflow.fade),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
