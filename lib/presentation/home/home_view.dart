import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dto/user_info.dart';
import '../../data/dto/user_repository.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  late HomeViewModel viewModel;

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    viewModel =
        Provider.of<HomeViewModel>(context); // Provider로 viewModel을 가져온다.
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Home'), // 앱 상단바 설정
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // 설정 다이어그램 연결
                },
              )
            ]),
        body: _homeView());
  }

  Widget _homeView() {
    final userData = viewModel.userInfo;
    final isLoaded = viewModel.isLoaded;

    return isLoaded
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _homeCardView(userData.userInfo),
                _repositoryList(userData.repoInfo),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _homeCardView(UserInfo data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.network(data.avatarUrl,
              width: 100, height: 100, fit: BoxFit.fill),
          Text(data.name.toString()),
          Text(data.login),
          Text('Followers: ${data.followers}  Following: ${data.following}'),
        ],
      ),
    );
  }

  Widget _repositoryList(List<RepositoryInfo> repoInfo) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: repoInfo.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
          child: ListTile(
            title: Text(repoInfo[index].name),
            subtitle: Text(repoInfo[index].description.toString()),
            onTap: () {},
          ),
        );
      },
    );
  }
}
