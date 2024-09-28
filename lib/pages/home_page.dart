import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomusers_provider/viewmodel/home_viewmodel.dart';
import '../item_of_random_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadRandomUserList();

    viewModel.scrollController.addListener(() {
      if (viewModel.scrollController.position.maxScrollExtent <=
          viewModel.scrollController.offset) {
        viewModel.loadRandomUserList();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(232, 232, 232, 1),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Random User - SetState"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child:Consumer<HomeViewModel>(
          builder:(context, model, index) => Stack(
            children: [
              ListView.builder(
                controller: viewModel.scrollController,
                itemCount: viewModel.userList.length,
                itemBuilder: (context, index) {
                  return itemOfRendomUser(viewModel.userList[index], index);
                },
              ),
              viewModel.isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}