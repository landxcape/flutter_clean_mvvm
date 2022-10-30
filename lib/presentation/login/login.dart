// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import '../common/state_renderer/state_renderer_impl.dart';
import '/app/app_prefs.dart';
import '/app/dependency_injection.dart';
import '/presentation/login/login_viewmodel.dart';
import '/presentation/resources/assets_manager.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/routes_manager.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() => _viewModel.setUsername(_usernameController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((isSuccessfullyLoggedIn) {
      // navigate to main screen
      _appPreferences.setIsUserLoggedIn();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
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
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                _viewModel.login();
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
              child: StreamBuilder<bool>(
                stream: _viewModel.outputIsUsernameValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: AppStrings.username.tr(),
                      labelText: AppStrings.username.tr(),
                      errorText: (snapshot.data ?? true) ? null : AppStrings.usernameError.tr(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: StreamBuilder<bool>(
                stream: _viewModel.outputIsPasswordValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: AppStrings.password.tr(),
                      labelText: AppStrings.password.tr(),
                      errorText: (snapshot.data ?? true) ? null : AppStrings.passwordError.tr(),
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
                                _viewModel.login();
                              }
                            : null,
                        child: const Text(AppStrings.login).tr(),
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
                  ).tr(),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.registerRoute);
                  },
                  child: Text(
                    AppStrings.registerText,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.end,
                  ).tr(),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
