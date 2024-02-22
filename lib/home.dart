import 'dart:convert';
import 'package:translate_1/home.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> lang = ['none'];
  String selectedItem = '';
  String y = '';


  Future<int> fetchLanguage() async {
    print('Fetchlanguage called');
    const url = 'https://google-translate1.p.rapidapi.com/language/translate/v2/languages';
    Map<String, String> head = {
      'X-RapidAPI-Key': 'a609bd23b8msh018ea2ecb50228bp1539bfjsna5841691f406',
      'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
    };
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: head);

    final body = response.body;
    final json = jsonDecode(body)['data']['languages'];
    for (int i = 0; i < json.length; i++) {
      lang.add(json[i]['language']);
    }

    print(lang);
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    String inival = lang[0];
    return Scaffold (
        backgroundColor: Colors.black,
        body: FutureBuilder<void>(
            future: fetchLanguage(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else
                return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            width: 500.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('TRANSLATE',
                                  textAlign: TextAlign.center,

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Ubuntubold',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30.0,
                                    letterSpacing: 2.0,


                                  ),


                                ),
                              ),
                            ),

                          ),
                          SizedBox(height: 40.0,),
                          SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child: TextField(
                              maxLines: null,
                              expands: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.cyanAccent,
                                      width: 10),
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                                hintText: 'ENTER TEXT',
                                suffixStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child: Container(
                              child: Text('$y',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,

                                ),

                              )
                              ,

                            ),
                          ),
                        ])
                );
               }),
        SizedBox(height: 40.0),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: Container(
                alignment: Alignment.centerLeft,
                height: 70.0,

                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),),),


              Padding(
                padding: const EdgeInsets.fromLTRB(
                    40.0, 0.0, 40.0, 0.0),
                child: SizedBox(
                  height: 70.0,
                  width: 100.0,
                  child: FloatingActionButton(onPressed: () {
                    translate();
                  },
                    backgroundColor: Colors.grey[300],
                    elevation: 5.0,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),


                    child: Icon(
                        Icons.translate_outlined,
                        color: Colors.black),
                  ),
                ),
              ),
              Expanded(child: Container(
                child: DropdownButton<String>(
                  value: selectedItem,
                  items: lang.map((item) =>
                      DropdownMenuItem<String>(
                        value: item,


                        child: Text(item,
                            style: TextStyle(fontSize: 24)),))
                      .toList(),
                  onChanged: (i) =>
                      setState(() => selectedItem = i!),)
                , decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),),),)


            ])
    );
  }


  Future<int> translate() async {
    print(' translate called');
    const url = 'https://google-translate1.p.rapidapi.com/language/translate/v2';
    Map<String, String> head = {
      'X-RapidAPI-Key': 'a609bd23b8msh018ea2ecb50228bp1539bfjsna5841691f406',
      'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
    };
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: head);

    final body = response.body;
    final json = jsonDecode(body)['data']['translations'][0] as String;

    y = json as String;

    print(json);
    return 1;
  }
}



