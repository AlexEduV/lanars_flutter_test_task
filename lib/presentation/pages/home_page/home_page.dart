import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/picture_entry.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/blocs/home_blocs.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/blocs/home_events.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/blocs/home_states.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/widgets/image_list_item.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (_) => HomeBloc()..add(LoadingPicturesEvent()),
      child: Scaffold(
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
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {

            if (state is HomeLoading) {

              //todo: redo the indicator to be smaller, not so distracting
              return const Center(child: CircularProgressIndicator(),);
            } else if (state is HomeLoaded) {

              return RefreshIndicator(
                onRefresh: () async => context.read<HomeBloc>().add(LoadingPicturesEvent()),
                child: ListView.separated(
                    padding: const EdgeInsets.only(top: 16.0),
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {

                      final result = state.results[index];
                      final bool isHeader = result['isHeader'];
                      final String letter = result['letter'];
                      final PictureEntry? entry = result['picture'];

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
                            child: entry != null ? ImageListItem(
                              imageSrc: entry.imageSrc,
                              title: entry.photographerName,
                              content: entry.altTitle,
                            ) : const SizedBox.shrink(),
                          )
                        ],
                      );

                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 16.0,)
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No data available'));
            }
          }),
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
                          fit: BoxFit.cover,
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
      )
    );
  }
}
