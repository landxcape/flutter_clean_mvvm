// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm/app/dependency_injection.dart';
import 'package:flutter_clean_mvvm/presentation/main/home/home_viewmodel.dart';

// Project imports:
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.home),
    );
  }
}
