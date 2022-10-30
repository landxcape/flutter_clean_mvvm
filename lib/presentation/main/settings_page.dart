// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm/app/app_prefs.dart';
import 'package:flutter_clean_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/routes_manager.dart';

// Project imports:
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/dependency_injection.dart';
import '../../data/data_source/local_data_source.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(
            AppStrings.changeLanguage,
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.contactUs,
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.inviteYourFriends,
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.logout,
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _logout();
          },
        ),
      ],
    );
  }

  void _changeLanguage() {
    // add localization
    _appPreferences.setLanguageChanged();
    Phoenix.rebirth(context); // restart to apply language changes
  }

  void _contactUs() {
    // redirect to webpage
  }

  void _inviteFriends() {
    // share app name with friends
  }

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();

    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
}
