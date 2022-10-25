// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:flutter_clean_mvvm/app/constants.dart';
import 'package:flutter_clean_mvvm/data/mapper/mapper.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker imagePicker = instance<ImagePicker>();

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
      padding: const EdgeInsets.only(top: AppPadding.p60),
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
                    keyboardType: TextInputType.name,
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
                    favorite: const [Constants.defaultCountryCode, '+966'],
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
                          hintText: AppStrings.mobileNumber,
                          labelText: AppStrings.mobileNumber,
                          errorText: snapshot.data,
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
            const SizedBox(height: AppSize.s28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: StreamBuilder<String?>(
                stream: _viewModel.outputErrorEmail,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppStrings.emailHint,
                      labelText: AppStrings.emailHint,
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
                    // keyboardType: TextInputType.visiblePassword,
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
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.lightGrey,
                  ),
                ),
                // child: GestureDetector(
                //   child: _getMediaWidget(),
                //   onTap: () {
                //     _showPicker(context);
                //   },
                // ),
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

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: Text(AppStrings.profilePicture),
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
                leading: const Icon(Icons.camera),
                trailing: const Icon(Icons.arrow_forward),
                title: const Text(AppStrings.photoGallery),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                trailing: const Icon(Icons.arrow_forward),
                title: const Text(AppStrings.photoCamera),
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
