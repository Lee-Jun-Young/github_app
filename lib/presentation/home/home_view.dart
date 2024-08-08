import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_app/presentation/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../custom_theme.dart';
import '../../data/dto/user_info.dart';
import '../../data/dto/user_repository.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  late HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _settingDialog();
                },
              );
            },
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _settingDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('테마',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: CustomThemeMode.themeMode,
              builder: (context, themeMode, child) {
                return Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: const Text('Light'),
                      value: ThemeMode.light,
                      groupValue: themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          CustomThemeMode.change(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text('Dark'),
                      value: ThemeMode.dark,
                      groupValue: themeMode,
                      onChanged: (value) {
                        if (value != null) {
                          CustomThemeMode.change(value);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    final state = viewModel.state;

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
