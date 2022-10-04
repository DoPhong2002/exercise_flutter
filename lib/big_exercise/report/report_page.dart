import 'package:Flutter_father/MyTextField.dart';
import 'package:Flutter_father/big_exercise/modun/Mybuttom.dart';
import 'package:Flutter_father/big_exercise/newsfeed/newfeed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../newsfeed/newfeed_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // final NewFeedCubit _newFeedCubit = NewFeedCubit();
  List? itemListSelected = [];
  String selectImage = '';
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerContent = TextEditingController();
  bool stateInit = true;

  void myInitState(NewFeedCubit newFeedCubit) {
    newFeedCubit.createListImage();
  }

  @override
  Widget build(BuildContext context) {
    final cubitProvider = BlocProvider.of<NewFeedCubit>(context);
    if (stateInit) {
      stateInit = false;
      myInitState(cubitProvider);
      cubitProvider.createListImage();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewFeedPage()),
              );
            },
            child: const Icon(Icons.account_box),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitleReport(),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                      onTap: showBottomSheet,
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/icons/imageNew.png')),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              buildOntapAdd()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOntapAdd() {
    final cubitProvider = BlocProvider.of<NewFeedCubit>(context);
    return MyButton(
      textButtom: 'Them',
      colorButton: Colors.cyanAccent,
      colorTextButton: Colors.black,
      onTapButtom: () {
        print('itemListSelected 1: $itemListSelected');
        if (_controllerTitle.text.isNotEmpty &&
                _controllerTitle.text.isNotEmpty ||
            _controllerTitle.text.isNotEmpty) {
          cubitProvider.addListReport(_controllerTitle.text,
              _controllerContent.text, itemListSelected!);
        }
        cubitProvider.listNewFeed = List.from(cubitProvider.listReport);
        itemListSelected = [];
        print('itemListSelected 2: $itemListSelected');
        _controllerContent.text = '';
        _controllerTitle.text = '';
      },
    );
  }

  Widget buildTitleReport() {
    return Column(
      children: [
        Column(
          children: [
            MyTextField(
              controller: _controllerTitle,
              textAlign: TextAlign.center,
              hintText: 'Tiêu đề',
              labelText: 'Tiêu đề',
              maxLines: 1,
              minLines: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            MyTextField(
              controller: _controllerContent,
              hintText: 'hello',
              labelText: 'Noi dung',
              minLines: 5,
              maxLines: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildGridViewImage() {
    final cubitProvider = BlocProvider.of<NewFeedCubit>(context);
    return GridView.builder(
      shrinkWrap: true,
      itemCount: cubitProvider.listImage.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (_, index) {
        return imageAdd(index);
      },
    );
  }

  Widget imageAdd(int index) {
    final cubitProvider = BlocProvider.of<NewFeedCubit>(context);
    return InkWell(
      onTap: () {
        print('con');
        selectImage = cubitProvider.listImage[index];
        if (!itemListSelected!.contains(selectImage)) {
          itemListSelected?.add(selectImage);
        }
      },
      child: Image.asset(cubitProvider.listImage[index]),
    );
  }

  Widget buildPopUp() {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 10),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ListView(
        children: [
          buildGridViewImage(),
        ],
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return buildPopUp();
      },
    );
  }
}