import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm/app/dependency_injection.dart';
import 'package:flutter_clean_mvvm/presentation/register/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameTextEditingController = TextEditingController();
  final TextEditingController _mobileNumberTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  _bind() {
    _viewModel.start();
    _usernameTextEditingController.addListener(() => _viewModel.setUsername(_usernameTextEditingController.text));
    _mobileNumberTextEditingController.addListener(() => _viewModel.setUsername(_mobileNumberTextEditingController.text));
    _emailTextEditingController.addListener(() => _viewModel.setUsername(_emailTextEditingController.text));
    _passwordTextEditingController.addListener(() => _viewModel.setUsername(_passwordTextEditingController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
