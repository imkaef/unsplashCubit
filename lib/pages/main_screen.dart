import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_pictures_bloc/entitys/picture.dart';
import 'package:unsplash_pictures_bloc/pages/cubit/pictures_cubit.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build bloc');
    return BlocProvider(
      create: (_) => PicturesCubit(),
      child: const _ListPictureWidget(),
    );
  }
}

class _ListPictureWidget extends StatelessWidget {
  const _ListPictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicturesCubit, PicturesState>(
      builder: (context, state) {
        if (state is PicturesInitial) {
          context.read<PicturesCubit>().loadPictures();
          return const _DownloadWidget();
        }
        if (state is PicturesLoadedState) {
          context.read<PicturesCubit>().loadPictures();
          return _LoadedWidget(
            state: state,
          );
        }
        if (state is PicturesErrorState) {
          return _ErrorWidget(
            state: state,
          );
        }
        return Container();
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    Key? key,
    required this.state,
  }) : super(key: key);
  final PicturesErrorState state;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Center(
          child: Text(state.errorMessage),
        ),
        onRefresh: () => context.read<PicturesCubit>().loadPictures());
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget({
    Key? key,
    required this.state,
  }) : super(key: key);
  final PicturesLoadedState state;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: picturesBuilder(context, state),
        onRefresh: () => context.read<PicturesCubit>().loadPictures());
  }
}

class _DownloadWidget extends StatelessWidget {
  const _DownloadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Widget picturesBuilder(BuildContext context, PicturesLoadedState state) {
  return ListView.builder(
    itemCount: state.pictures.length,
    itemBuilder: (context, index) {
      final item = state.pictures[index];
      if (index == state.pictures.length-2) {
        
      }
      return PictureCard(
        picture: item,
      );
    },
  );
}

class PictureCard extends StatelessWidget {
  const PictureCard({Key? key, required this.picture}) : super(key: key);
  final Picture picture;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.all(
          //   Radius.circular(20),
          // ),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(color: Colors.green, spreadRadius: 2),
          // ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                picture.user.profileImage?.large != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                              '${picture.user.profileImage?.large}'),
                          backgroundColor: Colors.transparent,
                        ),
                      )
                    : const SizedBox.shrink(),
                Text(
                  '${picture.user.firstName} ${picture.user.lastName}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            picture.urls?.regular != null
                ? Image.network(picture.urls!.regular)
                : const SizedBox.shrink(),
            // Image.network(picture.urls.full)
            Row(
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.favorite),
                ),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.add),
                      ),
                      TextButton(
                        onPressed: () => {},
                        child: const Text('Download'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _secondWidget(),
          ],
        ),
      ),
    );
  }
}

Widget _secondWidget() {
  return InkWell(
      onTap: () {},
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  decoration: myBoxDecoration(),
                  height: 55,
                  width: 30,
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                )),
            const Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ))),
          ],
        ),
      ));
}

BoxDecoration myBoxDecoration() {
  return const BoxDecoration(
    color: Colors.deepPurple,
    borderRadius:
        BorderRadius.all(Radius.circular(5.0) //         <--- border radius here
            ),
  );
}