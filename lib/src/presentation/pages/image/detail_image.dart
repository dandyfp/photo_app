import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_app/src/domain/models/image_model.dart';
import 'package:photo_app/src/presentation/helper/date_format.dart';

class DetailImage extends StatelessWidget {
  final ImageModel image;
  const DetailImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Back'),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: image.imagePath != null
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                          Uint8List.fromList(image.imagePath ?? []),
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 124,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xFFB1A7A6), width: 3),
                    ),
                    child: const Center(
                      child: CircleAvatar(
                        radius: 62,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            image.dateTime != null
                ? FormatDate().formatDate(image.dateTime,
                    context: context, format: 'dd-MM-yyy hh:mm:ss')
                : '',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${image.latitude}, ${image.longitude} ',
            style: const TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
