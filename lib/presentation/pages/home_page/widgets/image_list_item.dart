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
            padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24, left: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageSrc,
                    height: 56.0,
                    width: 64.0,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 16.0),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 24 / 16,
                          letterSpacing: 0.5,
                        ),
                      ),

                      Text(
                        content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 20 / 14,
                          letterSpacing: 0.25,
                        ),
                      ),

                    ],
                  ),
                ),



              ],
            ),
          ),
        )

      ],
    );
  }
}
