// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '/app/dependency_injection.dart';
import '/presentation/common/state_renderer/state_renderer_impl.dart';
import '/presentation/register/register_viewmodel.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() => _viewModel.setUsername(_usernameController.text));
    _mobileNumberController.addListener(() => _viewModel.setUsername(_mobileNumberController.text));
    _emailController.addListener(() => _viewModel.setUsername(_emailController.text));
    _passwordController.addListener(() => _viewModel.setUsername(_passwordController.text));
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
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            const Image(image: AssetImage(ImageAssets.splashLogo)),
            const SizedBox(height: AppSize.s28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: StreamBuilder<String?>(
                stream: _viewModel.outputErrorUsername,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: AppStrings.username,
                      labelText: AppStrings.username,
                      errorText: snapshot.data,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: StreamBuilder<String?>(
                stream: _viewModel.outputErrorPassword,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: AppStrings.password,
                      labelText: AppStrings.password,
                      errorText: snapshot.data,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.register();
                              }
                            : null,
                        child: const Text(AppStrings.login),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppPadding.p28, AppPadding.p8, AppPadding.p28, 0.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.forgetPasswordRoute);
                  },
                  child: Text(
                    AppStrings.forgetPassword,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.end,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.registerRoute);
                  },
                  child: Text(
                    AppStrings.registerText,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.end,
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
  
}
