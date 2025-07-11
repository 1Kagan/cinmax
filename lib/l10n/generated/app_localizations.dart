import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of GeneratedAppLocalizations
/// returned by `GeneratedAppLocalizations.of(context)`.
///
/// Applications need to include `GeneratedAppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: GeneratedAppLocalizations.localizationsDelegates,
///   supportedLocales: GeneratedAppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the GeneratedAppLocalizations.supportedLocales
/// property.
abstract class GeneratedAppLocalizations {
  GeneratedAppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static GeneratedAppLocalizations? of(BuildContext context) {
    return Localizations.of<GeneratedAppLocalizations>(
        context, GeneratedAppLocalizations);
  }

  static const LocalizationsDelegate<GeneratedAppLocalizations> delegate =
      _GeneratedAppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @login_screen_member_login.
  ///
  /// In en, this message translates to:
  /// **'Member Login'**
  String get login_screen_member_login;

  /// No description provided for @login_screen_member_login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please login with your credentials'**
  String get login_screen_member_login_subtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @button_remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get button_remember_me;

  /// No description provided for @button_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get button_login;

  /// No description provided for @marketplace_bulk_offer_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get marketplace_bulk_offer_error;

  /// No description provided for @contact_us_contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us_contact_us;

  /// No description provided for @login_state_account_in_use.
  ///
  /// In en, this message translates to:
  /// **'This account is currently in use'**
  String get login_state_account_in_use;

  /// No description provided for @login_state_user_status_should_be_valid.
  ///
  /// In en, this message translates to:
  /// **'User status should be valid'**
  String get login_state_user_status_should_be_valid;

  /// No description provided for @login_state_blocked.
  ///
  /// In en, this message translates to:
  /// **'Your account has been blocked'**
  String get login_state_blocked;

  /// No description provided for @login_state_password_not_valid.
  ///
  /// In en, this message translates to:
  /// **'Password is not valid'**
  String get login_state_password_not_valid;

  /// No description provided for @login_state_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get login_state_user_not_found;

  /// No description provided for @login_state_payment_issue.
  ///
  /// In en, this message translates to:
  /// **'Payment issue detected'**
  String get login_state_payment_issue;

  /// No description provided for @contact_us_title.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us_title;

  /// No description provided for @login_screen_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get login_screen_forget_password;

  /// No description provided for @contact_us_info.
  ///
  /// In en, this message translates to:
  /// **'For any issues or questions, feel free to contact us using the information below'**
  String get contact_us_info;

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Flutter Base App'**
  String get app_title;

  /// No description provided for @jeton.
  ///
  /// In en, this message translates to:
  /// **'Token'**
  String get jeton;

  /// No description provided for @weekly_per_unit.
  ///
  /// In en, this message translates to:
  /// **'Per week'**
  String get weekly_per_unit;

  /// No description provided for @view_all_tokens.
  ///
  /// In en, this message translates to:
  /// **'View All Tokens'**
  String get view_all_tokens;

  /// No description provided for @profile_detail.
  ///
  /// In en, this message translates to:
  /// **'Profile Detail'**
  String get profile_detail;

  /// No description provided for @add_photo.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get add_photo;

  /// No description provided for @my_favorite_movies.
  ///
  /// In en, this message translates to:
  /// **'My Favorite Movies'**
  String get my_favorite_movies;

  /// No description provided for @change_theme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get change_theme;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @light_theme.
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get light_theme;

  /// No description provided for @dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get dark_theme;

  /// No description provided for @system_theme.
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get system_theme;

  /// No description provided for @logout_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logout_confirmation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get login_failed;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @unknown_error.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get unknown_error;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @register_now.
  ///
  /// In en, this message translates to:
  /// **'Register Now!'**
  String get register_now;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @failed_to_fetch_movies.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch movies'**
  String get failed_to_fetch_movies;

  /// No description provided for @no_movies_found.
  ///
  /// In en, this message translates to:
  /// **'No movies found'**
  String get no_movies_found;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get read_more;

  /// No description provided for @read_less.
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get read_less;

  /// No description provided for @actors.
  ///
  /// In en, this message translates to:
  /// **'Actors'**
  String get actors;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @no_user_data.
  ///
  /// In en, this message translates to:
  /// **'No user data.'**
  String get no_user_data;

  /// No description provided for @limited_offer.
  ///
  /// In en, this message translates to:
  /// **'Limited Offer'**
  String get limited_offer;

  /// No description provided for @user_id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get user_id;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @turkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get turkish;

  /// No description provided for @limited_offer_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Get bonuses and unlock new chapters by choosing a token package!'**
  String get limited_offer_subtitle;

  /// No description provided for @your_bonuses.
  ///
  /// In en, this message translates to:
  /// **'Your Bonuses'**
  String get your_bonuses;

  /// No description provided for @premium_account.
  ///
  /// In en, this message translates to:
  /// **'Premium\nAccount'**
  String get premium_account;

  /// No description provided for @more_matches.
  ///
  /// In en, this message translates to:
  /// **'More\nMatches'**
  String get more_matches;

  /// No description provided for @showcase.
  ///
  /// In en, this message translates to:
  /// **'Showcase'**
  String get showcase;

  /// No description provided for @more_likes.
  ///
  /// In en, this message translates to:
  /// **'More\nLikes'**
  String get more_likes;

  /// No description provided for @select_package_to_unlock.
  ///
  /// In en, this message translates to:
  /// **'Select a token package to unlock'**
  String get select_package_to_unlock;

  /// No description provided for @register_success_message.
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Welcome, {name}'**
  String register_success_message(Object name);

  /// No description provided for @register_failed.
  ///
  /// In en, this message translates to:
  /// **'Registration Failed'**
  String get register_failed;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tempus varius a vitae interdum id tortor\nelementum tristique eleifend at.'**
  String get welcome_subtitle;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @login_now.
  ///
  /// In en, this message translates to:
  /// **'Login Now!'**
  String get login_now;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get email_required;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalid_email;

  /// No description provided for @password_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_required;

  /// No description provided for @account_not_found.
  ///
  /// In en, this message translates to:
  /// **'Account not found'**
  String get account_not_found;

  /// No description provided for @full_name_required.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get full_name_required;

  /// No description provided for @password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_min_length;

  /// No description provided for @password_again_required.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is required'**
  String get password_again_required;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @email_already_registered.
  ///
  /// In en, this message translates to:
  /// **'This email address is already registered.'**
  String get email_already_registered;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @password_again.
  ///
  /// In en, this message translates to:
  /// **'Password Again'**
  String get password_again;

  /// No description provided for @user_agreement_part1.
  ///
  /// In en, this message translates to:
  /// **'I have read and accept the '**
  String get user_agreement_part1;

  /// No description provided for @user_agreement_part2.
  ///
  /// In en, this message translates to:
  /// **'user agreement.'**
  String get user_agreement_part2;

  /// No description provided for @user_agreement_part3.
  ///
  /// In en, this message translates to:
  /// **' Please proceed by reading this agreement.'**
  String get user_agreement_part3;

  /// No description provided for @register_now_button.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get register_now_button;

  /// No description provided for @select_image_source.
  ///
  /// In en, this message translates to:
  /// **'Select Image Source'**
  String get select_image_source;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @photo_uploaded_successfully.
  ///
  /// In en, this message translates to:
  /// **'Your photo has been uploaded successfully.'**
  String get photo_uploaded_successfully;

  /// No description provided for @upload_failed.
  ///
  /// In en, this message translates to:
  /// **'Upload Failed'**
  String get upload_failed;

  /// No description provided for @upload_your_photos.
  ///
  /// In en, this message translates to:
  /// **'Upload Your Photos'**
  String get upload_your_photos;

  /// No description provided for @upload_photos_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Share your best moments with us.'**
  String get upload_photos_subtitle;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @please_select_photo.
  ///
  /// In en, this message translates to:
  /// **'Please select a photo to continue.'**
  String get please_select_photo;

  /// No description provided for @permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get permission_denied;

  /// No description provided for @camera_permission_message.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required to take photos. Please enable it in settings.'**
  String get camera_permission_message;

  /// No description provided for @gallery_permission_message.
  ///
  /// In en, this message translates to:
  /// **'Gallery permission is required to select photos. Please enable it in settings.'**
  String get gallery_permission_message;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;
}

class _GeneratedAppLocalizationsDelegate
    extends LocalizationsDelegate<GeneratedAppLocalizations> {
  const _GeneratedAppLocalizationsDelegate();

  @override
  Future<GeneratedAppLocalizations> load(Locale locale) {
    return SynchronousFuture<GeneratedAppLocalizations>(
        lookupGeneratedAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_GeneratedAppLocalizationsDelegate old) => false;
}

GeneratedAppLocalizations lookupGeneratedAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return GeneratedAppLocalizationsEn();
    case 'tr':
      return GeneratedAppLocalizationsTr();
  }

  throw FlutterError(
      'GeneratedAppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
