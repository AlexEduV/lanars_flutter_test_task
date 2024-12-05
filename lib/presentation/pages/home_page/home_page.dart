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
      body: Scaffold(),
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
