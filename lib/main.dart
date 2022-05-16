import 'package:flutter/material.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<WeatherModel>(
          future: WeatherRepository().getWeather('Pamulang'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, right: 25, left: 25),
                    child: Row(
                      children: const [
                        Text(
                          'Hari ini',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 25, left: 25),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${snapshot.data!.main.temp}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                              const TextSpan(
                                text: '°C',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Color.fromARGB(255, 236, 66, 4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // Weather Icon
                        Image.network(
                          'https://openweathermap.org/img/w/' + snapshot.data!.weather.icon + '.png',
                          scale: 0.5,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 25, left: 25, bottom: 20),
                    child: Row(
                      children: [
                        const Icon(
                          IconData(
                            0xf193,
                            fontFamily: 'MaterialIcons',
                          ),
                          color: Color.fromARGB(255, 253, 0, 0),
                        ),
                        Expanded(
                          child: Text(
                            snapshot.data!.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
