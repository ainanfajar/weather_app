import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/models/model.dart';
import 'package:weather_app/about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  DataService dataService = DataService();
  Weather weather = Weather();
  bool isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather API'),
        leading: Icon(
          Icons.menu,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isFetched
                  ? Column(
                      children: [
                        Image.network(
                            'http://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                        Text(
                          '${weather.temp}°',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          weather.description,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    )
                  : SizedBox(),
              Container(
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 50),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'City'),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    isFetched = true;
                    weather = await dataService.fetchData(controller.text);
                    setState(() {});
                  },
                  child: Text(
                    'Search City',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top: 10, bottom: 10)),
                        child: Text(
                          'About Me',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => About(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top: 10, bottom: 10)),
                        child: Text(
                          'My Github',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () async {
                          String url = 'https://github.com/ainanfajar';
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              forceWebView: true,
                            );
                          } else {
                            print("Couldn't open the link");
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
