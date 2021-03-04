//default flutter packages
export 'dart:io';
export 'dart:async';
export 'dart:convert';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_test/flutter_test.dart';

//app
export 'package:bluestack_test_app/app/app.dart';

//screens
export 'package:bluestack_test_app/app/src/screens/login_screen/login_screen.dart';
export 'package:bluestack_test_app/app/src/screens/home_screen/recommended_for_you.dart';
export 'package:bluestack_test_app/app/src/screens/home_screen/user_detail.dart';
export 'package:bluestack_test_app/app/src/screens/home_screen/home_screen.dart';

//blocs
export 'package:bluestack_test_app/app/src/blocs/login_bloc.dart';
export 'package:bluestack_test_app/app/src/blocs/home_screen_bloc.dart';
export 'package:bluestack_test_app/app/src/blocs/main_app_bloc.dart';

//models
export 'package:bluestack_test_app/app/src/models/user_model.dart';
export 'package:bluestack_test_app/app/src/models/game_model.dart';

//resources
export 'package:bluestack_test_app/app/src/resources/home_screen_provider.dart';
export 'package:bluestack_test_app/app/src/resources/login_provider.dart';
export 'package:bluestack_test_app/app/src/resources/repository.dart';

//utils
export 'package:bluestack_test_app/utils/strings.dart';
export 'package:bluestack_test_app/utils/widgets.dart';
export 'package:bluestack_test_app/utils/images.dart';
export 'package:bluestack_test_app/utils/apis/api_urls.dart';
export 'package:bluestack_test_app/utils/preference_keys.dart';
export 'package:bluestack_test_app/utils/preference_utils.dart';
export 'package:bluestack_test_app/utils/japanese.dart';
export 'package:bluestack_test_app/utils/english.dart';

//third party packges
export 'package:http/http.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:rxdart/rxdart.dart' hide Notification;
export 'package:shared_preferences/shared_preferences.dart';
export 'package:shimmer/shimmer.dart';
export 'package:flutter_localizations/flutter_localizations.dart';

//localizations
export 'package:bluestack_test_app/localization/localization.dart';
