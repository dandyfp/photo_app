import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_app/src/data/db_helper.dart';
import 'package:photo_app/src/domain/models/image_model.dart';
import 'package:photo_app/src/presentation/helper/navigator_helper.dart';
import 'package:photo_app/src/presentation/pages/covid/covid_page.dart';
import 'package:photo_app/src/presentation/pages/image/image_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? currentPosition;
  File? imageFile;
  Uint8List? bytes;
  DatabaseHelper dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.jpg'),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                onPressed: () {
                  _getCurrentLocation();
                },
                child: const Center(
                  child: Text(
                    'Take a Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImagePage(),
                      ));
                },
                child: const Center(
                  child: Text(
                    'List Data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                onPressed: () {
                  NavigatorHelper.push(context, const CovidPage());
                },
                child: const Center(
                  child: Text(
                    'API Covid 19',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (image != null) {
        imageFile = File(image.path);
        bytes = await image.readAsBytes();
        ImageModel data = ImageModel(
          latitude: currentPosition?.latitude.toString(),
          longitude: currentPosition?.longitude.toString(),
          dateTime: DateTime.now().toString(),
          imagePath: bytes?.toList(),
        );
        setState(() {
          dbHelper.insertImage(data);
        });
      }
      if (image == null) return;

      setState(() {});
    } on PlatformException catch (_) {}
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();

    setState(() {
      currentPosition = position;
      if (currentPosition?.latitude != null) {
        pickImage();
      }
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
