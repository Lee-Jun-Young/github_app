import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dto/user_info.dart';
import '../../data/dto/user_repository.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // 설정 다이어그램 연결
            },
          )
        ],
      ),
      body: _buildBody(viewModel.state),
    );
  }

  Widget _buildBody(HomeState state) {
    if (!state.isLoaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildUserCard(state.items.userInfo),
          _buildRepositoryList(state.items.repoInfo),
        ],
      ),
    );
  }

  Widget _buildUserCard(UserInfo userInfo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.network(
            userInfo.avatarUrl,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
          Text(userInfo.name.toString()),
          Text(userInfo.login),
          Text(
              'Followers: ${userInfo.followers}  Following: ${userInfo.following}'),
        ],
      ),
    );
  }

  Widget _buildRepositoryList(List<RepositoryInfo> repoInfo) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: repoInfo.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
          ),
          child: ListTile(
            title: Text(repoInfo[index].name),
            subtitle: Text(repoInfo[index].description ?? ''),
            onTap: () {
              // Repository 클릭 이벤트
            },
          ),
        );
      },
    );
  }
}
