import 'package:flutter/material.dart';
import 'package:lanars_flutter_test_task/data/services/dio_client.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/picture_entry.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/widgets/image_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int listSize = 0;
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();

    //init load the list
    loadList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('List Page'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadList,
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 16.0),
          itemCount: results.length,
          itemBuilder: (context, index) {

            final result = results[index];
            final bool isHeader = result['isHeader'];
            final String letter = result['letter'];
            final PictureEntry entry = result['picture'];

            //debugPrint(entry.toString());

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Opacity(
                  opacity: isHeader ? 1.0 : 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      letter,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        height: 24 / 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                      ),
                    ),
                  )
                ),

                Expanded(
                  child: ImageListItem(
                    imageSrc: entry.imageSrc,
                    title: entry.photographerName,
                    content: entry.altTitle,
                  ),
                )
              ],
            );

          },
          separatorBuilder: (context, index) => const SizedBox(height: 16.0,)
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20.0,),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 20 / 14
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [

                  ClipOval(
                    child: Image.network(
                      GlobalMockStorage.user.avatarImageSrc,
                      height: 56.0,
                      width: 56.0,
                    ),
                  ),

                  const SizedBox(width: 16.0,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        '${GlobalMockStorage.user.firstName} ${GlobalMockStorage.user.lastName}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 24.0 / 16.0,
                          letterSpacing: 0.5
                        ),
                      ),

                      Text(
                        GlobalMockStorage.user.email,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 16.0 / 12.0
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),



          ],
        ),
      ),
    );
  }

  Future<void> loadList() async {

    await DioClient.getPictures();

    //map the results
    results = _groupPicturesByFirstLetter(GlobalMockStorage.results);

    setState(() {});


  }

  List<Map<String, dynamic>> _groupPicturesByFirstLetter(List<PictureEntry> pictures) {
    final grouped = <Map<String, dynamic>>[];
    String? lastLetter;

    for (final PictureEntry picture in pictures) {
      final letter = picture.photographerName[0].toUpperCase();
      if (letter != lastLetter) {
        // Add header entry
        grouped.add({'isHeader': true, 'letter': letter, 'picture': picture});
        lastLetter = letter;
      }
      // Add picture entry
      grouped.add({'isHeader': false, 'letter': letter, 'picture': picture});
    }

    return grouped;
  }

}
