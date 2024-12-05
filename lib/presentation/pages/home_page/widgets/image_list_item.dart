import 'package:flutter/material.dart';

class ImageListItem extends StatelessWidget {

  final String imageSrc;
  final String title;
  final String content;

  const ImageListItem({
    required this.imageSrc,
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24, left: 24),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Image.network(
                    imageSrc,
                    height: 56.0,
                    width: 64.0,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 16.0),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(title),

                    Text(
                      content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],
                ),



              ],
            ),
          ),
        )

      ],
    );
  }
}
