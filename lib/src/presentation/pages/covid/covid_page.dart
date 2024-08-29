import 'package:flutter/material.dart';
import 'package:photo_app/src/data/api_datasource.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({super.key});

  @override
  State<CovidPage> createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  ApiDatasource apiDatasource = ApiDatasource();
  @override
  void initState() {
    hitApi();
    super.initState();
  }

  hitApi() async {
    await apiDatasource.fetchCovidData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Back'),
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder(
        future: apiDatasource.fetchCovidData(),
        builder: (context, snapshot) {
          var data = snapshot.data?.features?.first;
          return snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Confirmed',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Death',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Recofered',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Last Update',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ': ${data?.attributes?.confirmed.toString() ?? ''}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                ': ${data?.attributes?.deaths.toString() ?? ''}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                ': ${data?.attributes?.recovered.toString() ?? ''}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                ': ${data?.attributes?.lastUpdate.toString() ?? ''}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
