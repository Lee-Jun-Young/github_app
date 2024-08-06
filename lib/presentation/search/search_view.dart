import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/dto/user_info.dart';
import '../detail/detail_page.dart';
import 'search_viewmodel.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<SearchView> {
  late SearchViewModel viewModel;
  String searchText = '';
  late ScrollController _controller;
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _cardClickEvent(BuildContext context, String login) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(login: login),
      ),
    );
  }

  Future<void> _searchUser() async {
    viewModel.searchQuery(searchText);
  }

  Future<void> _loadMore() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      viewModel.loadMore();
    }
  }

  void _onSearchSubmitted(String value) {
    setState(() {
      searchText = searchTextController.text;
      _searchUser();
    });
  }

  void _onSearchPressed() {
    setState(() {
      searchText = searchTextController.text;
      _searchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<SearchViewModel>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          _buildSearchBar(),
          _buildSearchResult(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: _onSearchSubmitted,
        controller: searchTextController,
        decoration: InputDecoration(
          hintText: 'Search User',
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: _onSearchPressed,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResult() {
    final state = viewModel.state;

    if (!state.isLoaded && !state.isFirst) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.items.isEmpty && state.isLoaded) {
      return _buildEmptyView();
    } else {
      return Expanded(
        child: ListView.builder(
          controller: _controller,
          itemCount: state.items.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildResultCard(state.items[index]);
          },
        ),
      );
    }
  }

  Widget _buildResultCard(UserInfo item) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
      ),
      child: ListTile(
        leading: Image.network(
          item.avatarUrl,
          width: 56,
          height: 56,
        ),
        title: Text(item.name.toString()),
        subtitle: Text(item.login),
        onTap: () => _cardClickEvent(context, item.login),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Expanded(
      child: Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }
}
