// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '/app/app_prefs.dart';
import '/app/constants.dart';
import '/app/dependency_injection.dart';
import '/data/mapper/mapper.dart';
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
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final ImagePicker imagePicker = instance<ImagePicker>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() => _viewModel.setUsername(_usernameController.text));
    _mobileNumberController.addListener(() => _viewModel.setMobileNumber(_mobileNumberController.text));
    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((isSuccessfullyLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        // Navigator.of(context).pop();
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
      padding: const EdgeInsets.only(top: AppPadding.p30),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            const Image(image: AssetImage(ImageAssets.splashLogo)),
            const SizedBox(height: AppSize.s12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: StreamBuilder<String?>(
                stream: _viewModel.outputErrorUsername,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: AppStrings.username.tr(),
                      labelText: AppStrings.username.tr(),
                      errorText: snapshot.data,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: CountryCodePicker(
                    onChanged: (CountryCode countryCode) {
                      // update viewmodel with the selected code
                      _viewModel.setCountryCode(countryCode.dialCode ?? emptyString);
                    },
                    initialSelection: Constants.defaultCountryCode,
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    hideMainText: true,
                    favorite: const [Constants.defaultCountryCode, '+39'],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorMobileNumber,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _mobileNumberController,
                        decoration: InputDecoration(
                          hintText: AppStrings.mobileNumber.tr(),
                          labelText: AppStrings.mobileNumber.tr(),
                          errorText: snapshot.data,
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
            const SizedBox(height: AppSize.s4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: StreamBuilder<String?>(
                stream: _viewModel.outputErrorEmail,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppStrings.emailHint.tr(),
                      labelText: AppStrings.emailHint.tr(),
                      errorText: snapshot.data,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: StreamBuilder<String?>(
                stream: _viewModel.outputErrorPassword,
                builder: (context, snapshot) {
                  return TextFormField(
                    // keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: AppStrings.password.tr(),
                      labelText: AppStrings.password.tr(),
                      errorText: snapshot.data,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSize.s12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: Container(
                height: AppSize.s50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: AppSize.s1_5,
                    color: ColorManager.lightGrey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                ),
                child: GestureDetector(
                  child: _getMediaWidget(),
                  onTap: () {
                    _showPicker(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: AppSize.s12),
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
                        child: const Text(AppStrings.register).tr(),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppPadding.p28, AppPadding.p8, AppPadding.p28, 0.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppStrings.haveAccount,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.end,
                ).tr(),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: const Text(AppStrings.profilePicture).tr(),
          ),
          Flexible(
            child: StreamBuilder<File?>(
              stream: _viewModel.outputProfilePicture,
              builder: (context, snapshot) {
                return _imagePickedByUser(snapshot.data);
              },
            ),
          ),
          Flexible(
            child: SvgPicture.asset(ImageAssets.photoCameraIc),
          ),
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    }
    return Container();
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_album),
                trailing: const Icon(Icons.arrow_forward),
                title: const Text(AppStrings.photoGallery).tr(),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                trailing: const Icon(Icons.arrow_forward),
                title: const Text(AppStrings.photoCamera).tr(),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _imageFromGallery() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

    _viewModel.setProfilePicture(File(image?.path ?? ''));
  }

  _imageFromCamera() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);

    _viewModel.setProfilePicture(File(image?.path ?? ''));
  }
}
