import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_test_ui/models/news_model.dart';
import 'package:whatsapp_test_ui/services/news_service.dart';
import 'package:whatsapp_test_ui/widgets/article_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

// with AutomaticKeepAliveClientMixin
class _NewsScreenState extends State<NewsScreen> {
  final List<NewsModel> _newsList = [];
  bool _viewStream = true;
  bool _isLoading = true;
  final ScrollController _listScrollController = ScrollController();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getNewsArticle();
    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;
      if (maxScroll - currentScroll <= 150) {
        if (!_isLoading) {
          _getNewsArticle();
        }
      }
    });
  }

  _getNewsArticle({bool refresh = false}) async {
    setState(() {
      _isLoading = true;
    });

    var response = await NewsService.getNews();

    setState(() {
      if (refresh) _newsList.clear();
      _newsList.add(response['articles']);
      // _newsList.addAll(response['articles']);
      _isLoading = false;
    });
  }

  Widget loadingView() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.teal[900],
      ),
    );
  }

  Widget listIsEmpty() {
    return const Center(
      child: Text('هیج اطلاعاتی برای نمایش وجود ندارد!'),
    );
  }

  Future _handleRefresh() async {
    await _getNewsArticle(refresh: true);
  }

  Widget streamListView() {
    return _newsList.isEmpty && _isLoading
        ? loadingView()
        : _newsList.isEmpty
            ? listIsEmpty()
            : RefreshIndicator(
                color: Colors.orange,
                child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    controller: ScrollController(),
                    itemCount: _newsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ArticleCard(
                        newsModel: _newsList[index],
                        url: _newsList[index].url!,
                      );
                    }),
                onRefresh: _handleRefresh);
  }

  Widget moduleListView() {
    return _newsList.isEmpty && _isLoading
        ? loadingView()
        : _newsList.isEmpty
            ? listIsEmpty()
            : RefreshIndicator(
                color: Colors.orange,
                child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    controller: ScrollController(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: _newsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ArticleCard(
                        newsModel: _newsList[index],
                        url: _newsList[index].url!,
                      );
                    }),
                onRefresh: _handleRefresh);
  }

  Widget headList() {
    return SliverAppBar(
      primary: false,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _viewStream = true;
              });
            },
            child: Icon(Icons.view_stream,
                color: _viewStream ? Colors.grey[800] : Colors.grey[500]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _viewStream = false;
              });
            },
            child: Icon(Icons.view_module,
                color: _viewStream ? Colors.grey[500] : Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: NestedScrollView(
              controller: _listScrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return _newsList.isNotEmpty ? <Widget>[headList()] : [];
              },
              body: _viewStream ? streamListView() : moduleListView()),
        ),
      ),
    );
  }
}
