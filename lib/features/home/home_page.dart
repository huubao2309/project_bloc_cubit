import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_bloc_cubit/base/base_init.dart';
import 'package:project_bloc_cubit/features/home/footer/footer_home_cubit.dart';
import 'package:project_bloc_cubit/features/home/footer/footer_home_state.dart';
import 'package:project_bloc_cubit/features/home/home_page_cubit.dart';
import 'package:project_bloc_cubit/features/home/home_page_state.dart';
import 'package:project_bloc_cubit/features/home/notification/notification_home_cubit.dart';
import 'package:project_bloc_cubit/features/home/notification/notification_home_state.dart';
import 'package:project_bloc_cubit/models/home_item_model.dart';
import 'package:project_bloc_cubit/models/home_model.dart';
import 'package:project_bloc_cubit/routes/define_routes.dart';
import 'package:flutter/material.dart';
import 'package:project_bloc_cubit/utils/extension_navigation.dart';
import 'package:project_bloc_cubit/utils/utils_app.dart';
import 'package:project_bloc_cubit/widgets/appbar_widget.dart';
import 'package:project_bloc_cubit/widgets/loading_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final _cubitHomePage = getIt.get<HomePageCubit>();
  final _cubitNotification = getIt.get<NotificationHomeCubit>();
  final _cubitFooter = getIt.get<FooterHomeCubit>();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    var hasOnline = false;
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer t) {
        _cubitFooter.changeStatusFooter(hasOnline: hasOnline);
        final fileName = hasOnline ? '1.json' : '2.json';
        _cubitHomePage.changeItemList(fileName).then((value) {
          printLog('Return value at Home');
        });

        hasOnline = !hasOnline;
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void onStateChange(Object? state) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: Column(
        children: [
          Expanded(child: _buildListItem()),
          const SizedBox(height: 10),
          _buildFooterHome(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    printLog('11111. Rebuild _buildAppbar');
    return AppBarStandard(
      title: 'Home Page',
      isVisibleBackButton: false,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocProvider(
            create: (_) => _cubitNotification,
            child: BlocConsumer<NotificationHomeCubit, NotificationHomeState>(
              listener: (context, state) {
                // onStateChange(state);
              },
              builder: (context, state) {
                printLog('11111. 11111 Rebuild _buildAppbar with value');
                if (state is NotificationReadHome) {
                  return const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  );
                }

                return const Icon(
                  Icons.notification_add,
                  color: Colors.white,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem() {
    printLog('222222. Rebuild _buildListItem');
    return Scrollbar(
        controller: _scrollController,
        child: BlocProvider(
          create: (_) => _cubitHomePage,
          child: BlocConsumer<HomePageCubit, HomePageState>(
            listener: (context, state) {
              // onStateChange(state);
            },
            builder: (context, state) {
              printLog('222222. 22222 Rebuild _buildListItem with value');
              if (state is HomePageFailed) {
                return Center(
                  child: Text(
                    'Error: ${state.errorMsg}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              if (state is HomePageLoading) {
                return const LoadingView();
              }

              final model = (state as HomePageInitDataLoaded).homeModel;
              return ListView(
                children: _createListViewItems(model),
              );
            },
          ),
        ));
  }

  Widget _buildFooterHome() {
    printLog('333333. Rebuild _buildFooterHome');
    return BlocProvider(
      create: (_) => _cubitFooter,
      child: BlocConsumer<FooterHomeCubit, FooterHomeState>(
        listener: (context, state) {
          // onStateChange(state);
        },
        builder: (context, state) {
          printLog('333333. 11111 Rebuild _buildFooterHome with value');
          if (state is FooterOfflineHome) {
            return _footerWidget(Colors.deepOrange);
          }

          return _footerWidget(Colors.green);
        },
      ),
    );
  }

  Widget _footerWidget(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      color: color,
      child: Row(
        children: [
          const Text(
            'Bao test',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            '${DateTime.now()}',
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _createListViewItems(HomeModel model) {
    final widgets = <Widget>[];
    if (model.data == null || model.data!.isEmpty) {
      return <Widget>[];
    }

    for (var i = 0; i < model.data!.length; i++) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: _childItem(model.data!.elementAt(i)),
      ));
    }

    return widgets;
  }

  Widget _childItem(HomeItemModel item) {
    return GestureDetector(
      onTap: () {
        navigateToDetail(item.count.toString());
      },
      child: Container(
        color: item.count! % 2 == 0 ? Colors.blue : Colors.red,
        height: 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Item: ${item.count.toString()}',
                ),
              ),
              const SizedBox(),
              Text(item.time!),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToDetail(String item) {
    GetNavigation.instance.toNamed(
      context,
      routeNamedDetailPage,
      arguments: item,
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }
}
