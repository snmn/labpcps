import 'package:demo/api/getapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/newsapi.dart';

class NewsUI extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NewsUIState();
  }
}
class NewsUIState extends State<NewsUI>{

  late Future<Newsapi?>? _futurehorizontallist;
  late Future<Newsapi?>? _futureverticallist;

  horizontalcard(var size, Articles article){
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Stack(
          children:[
            Container(
              height: size.height/4,
              width: size.width/1.5,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(article.urlToImage!,
                  fit: BoxFit.cover,),
              ),
            ),
            Positioned(
              left: 15,
              bottom: 70,
              child: Container(
                  width: size.width/1.7,
                  child:
                   Text(article.title!,maxLines: 2,style:
                  TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
            ),
             Positioned(bottom: 10,left: 15,child: Text(formatDateTimestring(article.publishedAt!),
              style:
              TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.normal),),),
            const Positioned(right: 10,bottom: 10,child:
            Icon(Icons.play_circle,size: 40,color: Colors.white,))
          ]
      ),
    );
  }

  verticalcard(var size, Articles article){
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //stack
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(article.urlToImage!,
                        fit: BoxFit.cover,),
                    ),
                  ),
                  const Positioned(left: 85,top: 60,child:
                  Icon(Icons.play_circle,color: Colors.white,size: 30,))
                ],
              )
            ],
          ),
          // text
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width/2,
                child:  Text(article.title!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 14,
                      color: Colors.black
                  ),maxLines: 2,),
              ),
              //row
              // button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:  Text(article.author!,
                      style: TextStyle(color: Colors.white,fontSize: 10),),
                  ),
                   Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(formatDateTimestring(article.publishedAt!),
                      style: TextStyle(color: Colors.black54,fontSize: 12),),
                  )
                ],
              )
              // tex


            ],
          )
        ],
      ),
    );
  }

  apicallh(){
    _futurehorizontallist = GetApi.getnewsdata();
  }
  apicallv(){
    _futureverticallist = GetApi.getnewsdata();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicallh();
    apicallv();
  }

  String formatDateTimestring(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("MMM dd, yyyy");
    date = longdate.format(format);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // horizontal list
            //stack // image // text // date // icon
            //futurebuilder horizontal list
              FutureBuilder<Newsapi?>(
              future:_futurehorizontallist,
              builder: (BuildContext context, AsyncSnapshot<Newsapi?> snapshot){
                switch (snapshot.connectionState){
                  case ConnectionState.none:
                    return Container(); // error
                  case ConnectionState.waiting: //loading
                    return Container(height: 20,width: 20,child: const Center(child: CircularProgressIndicator()),);
                  case ConnectionState.done:
                    if(snapshot.data==null || snapshot.data!.articles!.isEmpty){
                      return Container(child: Text("No data"),);// no data
                    }else{
                      //ui
                      var newshdata = snapshot.data;
                      return Container(
                        height: size.height/4,
                        width: size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: newshdata!.articles!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return horizontalcard(size,newshdata!.articles![index]);
                          },
                        ),
                      );
                    }
                  default:
                    return Container();//error page
                }
              }),
            //vertical list
            //Row
            //Col
            //stack // image // icon //center

            //futurebuilder vertical list
              FutureBuilder<Newsapi?>(
                future:_futureverticallist,
                builder: (BuildContext context, AsyncSnapshot<Newsapi?> snapshot){
                  switch (snapshot.connectionState){
                    case ConnectionState.none:
                      return Container(); // error
                    case ConnectionState.waiting: //loading
                      return Container(height: 20,width: 20,child: const Center(child: CircularProgressIndicator()),);
                    case ConnectionState.done:
                      if(snapshot.data==null || snapshot.data!.articles!.isEmpty){
                        return Container(child: Text("No data"),);// no data
                      }else{
                        //ui
                        var newsvdata = snapshot.data;
                        return Container(
                          width: size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            primary: true,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: newsvdata!.articles!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return verticalcard(size,newsvdata.articles![index]);
                            },
                          ),
                        );
                      }
                    default:
                      return Container();//error page
                  }
                }),
            //Col // text
            // row // container // text  /// date

          ],
        ),
      ),
    );
  }

}