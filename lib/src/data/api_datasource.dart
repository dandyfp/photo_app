import 'package:dio/dio.dart';
import 'package:photo_app/src/domain/models/covid_model.dart';

class ApiDatasource {
  Future<CovidModel?> fetchCovidData() async {
    final Dio dio = Dio();

    // The API endpoint
    const String url =
        'https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/Coronavirus_2019_nCoV_Cases/FeatureServer/1/query?where=UPPER(Country_Region)%20like%20%27%25INDONESIA%25%27&outFields=Last_Update,Recovered,Deaths,Confirmed&returnGeometry=false&outSR=4326&f=json';

    try {
      final Response response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        return CovidModel.fromJson(data);
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}
