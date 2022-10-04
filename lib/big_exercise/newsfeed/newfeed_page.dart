import 'package:Flutter_father/big_exercise/newsfeed/newfeed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewFeedPage extends StatefulWidget {
  const NewFeedPage({Key? key}) : super(key: key);

  @override
  State<NewFeedPage> createState() => _NewFeedPageState();
}

class _NewFeedPageState extends State<NewFeedPage> {
  @override
  Widget build(BuildContext context) {
    final cubitProvider = BlocProvider.of<NewFeedCubit>(context);
    print('so luong pt mh 2: ${cubitProvider.listNewFeed}');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Sự cố'),
        ),
        body: listViewNewFeed());
  }

  Widget listViewNewFeed() {
    final cubit = BlocProvider.of<NewFeedCubit>(context);
    if (cubit.listNewFeed.isNotEmpty) {
      return ListView.separated(
        itemBuilder: (context, index) {
          return BuildNewFeed(
            newFeedModel: cubit.listNewFeed[index],
          );
        },
        separatorBuilder: (BuildContext context, state) {
          return Container(
            height: 8,
          );
        },
        itemCount: cubit.listNewFeed.length,
      );
    }
    return Container();
  }
}

class BuildNewFeed extends StatelessWidget {
  final NewFeedModel newFeedModel;
  String datetime = DateTime.now().toString();

   BuildNewFeed({Key? key, required this.newFeedModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildItemNewFeed();
  }

  Widget buildItemNewFeed() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueAccent)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildTitleNewFeed(), buildStatus(), buildImage()],
      ),
    );
  }
  Widget buildTitleNewFeed() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Image.network('${newFeedModel.urlPictureAvt}'),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text('Đỗ Hồng Phong'),
                    Text(datetime),
                  ],
                ),
              ],
            ),
            const Text('Khong duyet'),
          ],
        ),
        const SizedBox(height: 4),
        Container(height: 1, color: Colors.grey[300]),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget buildStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '${newFeedModel.textTitleNewFeed}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('${newFeedModel.textContentNewFeed}'),
      ],
    );
  }

  int cuontGridView() {
    int a = newFeedModel.urlPicture!.length;
    if (a == 2) {
      return a = 2;
    } else if (a == 1) {
      return a = 1;
    }
    return a = 2;
  }

  int cuontView() {
    int a = newFeedModel.urlPicture!.length;
    return a;
  }

  Widget buildImage() {
    if (cuontView() > 4) {
      return Stack(
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cuontGridView(),
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (_, index) {
              final image = newFeedModel.urlPicture![index];
              return Image.asset(image);
            },
          ),
          Positioned(
            right: 30,
            bottom: 30,
            child: Container(
              child: Text(
                "+${cuontView() - 4}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  color: Colors.cyanAccent.withOpacity(0.3),
                ),
              ),
            ),
          )
        ],
      );
    } else if (cuontView() == 0) {
      return SizedBox();
    }
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: newFeedModel.urlPicture?.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cuontGridView(),
        crossAxisSpacing: 4,
        mainAxisSpacing: 0,
      ),
      itemBuilder: (_, index) {
        final image = newFeedModel.urlPicture![index];

        return Image.asset(image);
      },
    );
  }
}