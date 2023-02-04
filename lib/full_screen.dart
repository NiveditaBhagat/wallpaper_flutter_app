import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;
  const FullScreen({super.key, required this.imageurl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {

Future<void>setWallpaper()async{
  int location=WallpaperManager.HOME_SCREEN;
  var file=await DefaultCacheManager().getSingleFile(widget.imageurl);
  String result=await WallpaperManager.setWallpaperFromFile(file.path,location);
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Column(
          children:<Widget>[
            Expanded(
              child: Container(
                child: Image.network(widget.imageurl),
              ),
              ),
              InkWell(
            onTap: () {
              setWallpaper();
            },
            child: Container(
              height: 60.0,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text(
                  'Set Wallpaper',
                  style: TextStyle(
                    fontSize: 20.0, color: Colors.white,
                  ),
                ),
              ),
            ),
          )
          ],
        ),
      )
    );
  }
}