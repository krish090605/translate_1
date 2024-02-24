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


  List<String> lang = ['none'];
  String selectedLang = 'none';
  String y = '';
  String getDropdownItems = '';
  String detectedLanguage = '';
  String translatedOutput = '';
  TextEditingController _textController = TextEditingController();

  fetchLanguage() async {
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
    setState(() {});
  }
  @override
  void initState() {
    fetchLanguage();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    String inival = lang[0];
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
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
                    child: const Padding(
                      padding:  EdgeInsets.all(10.0),
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
                  const SizedBox(height: 40.0,),
                  SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      controller: _textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Colors.cyanAccent,
                              width: 10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: 'ENTER TEXT',
                        suffixStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),

                    ),
                  ),
                  const SizedBox(height: 40.0),
                  SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: Container(
                      color: Colors.grey[300],
                      child:  Text('$translatedOutput',
                        style:const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,

                        ),

                      )
                      ,

                    ),
                  ),


                  const SizedBox(height: 40.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: Container(
                          alignment: Alignment.centerLeft,
                          height: 70.0,
                          child: Text('$detectedLanguage'),

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
                            child: FloatingActionButton(
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: () async{
                                    String text = _textController.text;
                                    String detectedLanguage = await detectLanguage(text);
                                    print('Detected Language: $detectedLanguage');
                                    String translatedOutput = await translateText(text, selectedLang, detectedLanguage);
                                    print('Required output : $translatedOutput');
                                    },


                              child:const Icon(
                                  Icons.translate_outlined,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(child: Container(
                          alignment: Alignment.centerLeft,
                          height: 70.0,
                         child: Center(
                            child: DropdownButtonExample(lang: lang),
                          ),

                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),),),

                      ])
                ]
            )
        )
    );
  }





}
Future<String> detectLanguage(String text) async {
  // Your RapidAPI key and host
  const url = 'https://google-translate1.p.rapidapi.com/language/translate/v2';

  // Set up the detection request
  Map<String, String> headers = {
    'X-RapidAPI-Key': 'a609bd23b8msh018ea2ecb50228bp1539bfjsna5841691f406',
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'

  };
  String uri = "https://google-language-translator-detection.p.rapidapi.com/translate/v2/languages";
  Map<String, String> body = {
    "q": text,
  };

  // Make the detection request
  http.Response response = await http.post(
    Uri.parse(uri),
    headers: headers,
    body: body,
  );
  Map<String, dynamic> data = jsonDecode(response.body);

  // Return the detected language code
  return data['data']['detections'][0]['language'];
}
class DropdownButtonExample extends StatefulWidget {
  final List<String> lang;

  DropdownButtonExample({required this.lang});

  @override
  _DropdownButtonExampleState createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? selectedLang = 'none';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedLang,
      items: widget.lang.map((String lang) {
        return DropdownMenuItem<String>(
          value: lang,
          child: Text(lang),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedLang = newValue;
        });
      },
    );
  }
}
Future<String> translateText(String text, String targetLanguage, String sourceLanguage) async {

  const url = 'https://google-translate1.p.rapidapi.com/language/translate/v2';
  // Your RapidAPI key and host
    Map<String, String> headers = {
    'X-RapidAPI-Key': 'a609bd23b8msh018ea2ecb50228bp1539bfjsna5841691f406',
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'

  };
  String uri = "https://google-translate1.p.rapidapi.com/language/translate/v2";
  Map<String, String> body = {
    "q": text,
    "source": sourceLanguage,
    "target": targetLanguage,
    "format": "text"
  };


  http.Response response = await http.post(
    Uri.parse(uri),
    headers: headers,
    body: body,
  );
  Map<String, dynamic> data = jsonDecode(response.body);

  // Return the translated text
  return data['data']['translations'][0]['translatedText'];
}