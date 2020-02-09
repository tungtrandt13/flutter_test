import 'dart:async';
//import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class GetRss {

  static Future<List<Album>> getRss() async {
    var data = await http.get(
        "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.rss",
        headers: {
          "Content-Type": "application/json"
        });
    var rssFeed = new RssFeed.parse(data.body);
    List<Album> noticias = new List();
    for (int i = 0; i < rssFeed.items.length; i++) {
      print("title: " + rssFeed.items[i].title);
      print("Descripcion: " + rssFeed.items[i].description);//fuck
      print("pubDate: " + rssFeed.items[i].pubDate);
      print("Enplace link: " + rssFeed.items[i].link);
      print("\n");

      noticias.add(new Album(rssFeed.items[i].title, rssFeed.items[i].description, rssFeed.items[i].pubDate, rssFeed.items[i].link));
    }

    return noticias;
  }

}

class Album {

  String _titulo, _descripcion, _fecha, _urlNoticia;

  Album(this._titulo, this._descripcion, this._fecha, this._urlNoticia);

  get urlNoticia => _urlNoticia;

  set urlNoticia(value) {
    _urlNoticia = value;
  }

//  get urlImagen => _urlImagen;

//  set urlImagen(value) {
//    _urlImagen = value;
//  }

  get fecha => _fecha;

  set fecha(value) {
    _fecha = value;
  }

  get descripcion => _descripcion;

  set descripcion(value) {
    _descripcion = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }


}