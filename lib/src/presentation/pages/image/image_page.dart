import 'package:flutter/material.dart';
import 'package:photo_app/src/data/db_helper.dart';
import 'package:photo_app/src/presentation/helper/date_format.dart';
import 'package:photo_app/src/presentation/helper/navigator_helper.dart';
import 'package:photo_app/src/presentation/pages/image/detail_image.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await dbHelper.getListImage();
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
        future: dbHelper.getListImage(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 30,
                  ),
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data![index];
                      return ListTile(
                        onTap: () {
                          NavigatorHelper.push(
                              context, DetailImage(image: item));
                        },
                        shape: const Border(
                          bottom: BorderSide(color: Colors.black),
                        ),
                        title: Text(
                          item.dateTime != null
                              ? FormatDate().formatDate(item.dateTime,
                                  context: context,
                                  format: 'dd-MM-yyy hh:mm:ss')
                              : '-',
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
