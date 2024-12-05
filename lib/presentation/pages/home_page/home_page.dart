import 'package:flutter/material.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 16.0),
        itemCount: 30,
        itemBuilder: (context, index) {

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
                          GlobalMockStorage.user.avatarImageSrc,
                          height: 56.0,
                          width: 64.0,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 16.0),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text('Some name here'),

                          Text(
                            'Alt text here',
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

        },
        separatorBuilder: (context, index) {

          return const SizedBox(height: 16.0,);
        },
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
}
