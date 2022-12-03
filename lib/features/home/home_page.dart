import 'package:project_bloc_cubit/routes/define_routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        print('Call Navigate to Detail');
        final args = ModalRoute.of(context)!.settings.arguments.toString();
        navigateToDetail(args);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
          itemCount: 1000,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return ListTile(
              title: _childItem(index),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _createListViewItems(int numberOfList) {
    final widgets = <Widget>[];
    for (var i = 0; i < numberOfList; i++) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: _childItem(i),
      ));
    }

    return widgets;
  }

  Widget _childItem(int item) {
    return GestureDetector(
      onTap: () {
        navigateToDetail(item.toString());
      },
      child: Container(
        color: item % 2 == 0 ? Colors.blue : Colors.red,
        height: 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Item: ${item.toString()}',
          ),
        ),
      ),
    );
  }

  void navigateToDetail(String item) {
    Navigator.pushNamed(
      context,
      routeNamedDetailPage,
      arguments: item,
    );
  }
}
