import 'dart:async';
import 'package:http/http.dart' as http;

class LoripsumApi {
  static Future<String> getLoripsum() async {
    var url = "https://loripsum.net/api";

    print("GET > $url");

    var response = await http.get(url);
    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}

class LoripsumBloc {
  static String lori;
  final _streamController = StreamController<String>();
  Stream<String> get stream => _streamController.stream;

  fetch() async {
    String s = lori ?? await LoripsumApi.getLoripsum();
    lori = s;
    _streamController.add(s);
  }

  void dispose(){
    _streamController.close();
  }
}
