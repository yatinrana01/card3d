import 'package:flutter/material.dart';

class Productcard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;
  final VoidCallback? ontap;
  Productcard({
    super.key,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(15),
                  child: Image.network(
                    imgUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image),
                  ),
                ),
              ),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(description,overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
      ),
    );
  }
}
