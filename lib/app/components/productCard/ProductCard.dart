import 'package:flutter/material.dart';

class Productcard extends StatelessWidget {
  String imgUrl;
  String title;
  String description;
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
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                imgUrl,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image),
              ),
            ),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(description,overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }
}
