// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_flutter/full_screen.dart';
import 'dart:convert';


class Wallpaper extends StatefulWidget {


  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
    List images=[]; 
    int pageNum=1;
  @override
  void initState(){
    super.initState();
    fetchApi();
  }

  fetchApi()async{
  await http.get(
    Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
    headers: {
      'Authorization': 'tzRuLvKYCUPbMl0We7poCfdKxu3bb0eo42ApcmNJx2VlyWijtvcfi9Zf'
    }).then((value){
      Map result=jsonDecode(value.body);
      setState(() {
        images=result['photos'];
      });
      print(images);
    });
  }

  loadmore()async{
    setState(() {
      pageNum++;
    });
    String url='https://api.pexels.com/v1/curated?per_page=80&page='+pageNum.toString();
    await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'tzRuLvKYCUPbMl0We7poCfdKxu3bb0eo42ApcmNJx2VlyWijtvcfi9Zf'
    }).then((value) {
      Map result=jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 2,crossAxisCount: 3,childAspectRatio: 2/3,mainAxisSpacing: 2), 
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(imageurl: images[index]['src']['large2x']),));
                    },
                    child: Container(color: Colors.white,
                    child: Image.network(images[index]['src']['tiny'],fit: BoxFit.cover,),
                    ),
                  );
                },
                itemCount: images.length,
                ),
            ),
          ),
          InkWell(
            onTap: () {
              loadmore();
            },
            child: Container(
              height: 60.0,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text(
                  'Load more',
                  style: TextStyle(
                    fontSize: 20.0, color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}