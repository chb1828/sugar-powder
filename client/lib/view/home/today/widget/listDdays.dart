import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/provider/dday_infinite_provider.dart';
import 'package:sugar_client/view/home/today/widget/listDdayTiles.dart';


class ListDDays extends StatefulWidget {

  String ddaySortType;
  
  ListDDays(this.ddaySortType);

  @override
  _ListDDaysState createState() => _ListDDaysState(ddaySortType);
}

class _ListDDaysState extends State<ListDDays> {
  String ddaySortType;
  _ListDDaysState(this.ddaySortType);

  int pageNumber;
  bool itemCheck = true;

  @override
  void initState() {
    super.initState();
    Provider.of<DDayInfiniteProvider>(context, listen: false).init();
    Future.microtask(() {
      Provider.of<DDayInfiniteProvider>(context, listen: false).fetchItems();
    });
  }


  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<DDayInfiniteProvider>(context);

    var cache = provider.cache;

    var loading = provider.loading;


    //로딩중이면서 캐시에 아무것도 없음
    if(cache==null || loading && cache.length == 0) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Center(
          child: CircularProgressIndicator(),
        )
      );
    }

    //로딩중이 아닌데 캐시에 아무것도 없음
    //아무것도 가져올 아이템이 없을때
    if(!loading && cache.length == 0) {
      return Container(
        height: 150,
        child: Center(child: Text("기억하고 싶은 디데이를 등록해보세요"),),
      );
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cache.length + 1,
      itemBuilder: (context, index) {
        if (index < cache.length) {
          return Column(
            
            children: [
              DDayTile(
                  cache[index].id,
                  cache[index].title,
                  cache[index].emoji,
                  cache[index].date,
                  cache[index].color,
                  cache[index].ddayType,
                  cache[index].followerCount)
            ],
          );
        }

        if(!provider.loading && provider.hasMore) {

          Future.microtask(() {
            provider.fetchItems();
          });
        }

        if(provider.hasMore) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }else {
          return Container();
        }
      },
    );

  }
}
