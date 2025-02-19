import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:base_project/data/model/user/user.dart';
import 'package:base_project/views/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:base_project/views/screens/about/faq/faq_screen.dart';
import 'package:base_project/views/screens/about/privacy/privacy_screen.dart';
import 'package:base_project/views/screens/account/change-password/change_password_screen.dart';
import 'package:base_project/views/screens/account/edit-profile/edit_profile_screen.dart';
import 'package:base_project/views/screens/account/profile/my_profile_screen.dart';
import 'package:base_project/views/screens/auth/email_verification_page/email_verification_screen.dart';
import 'package:base_project/views/screens/auth/forget-password/forget_password_screen.dart';
import 'package:base_project/views/screens/auth/kyc/kyc.dart';
import 'package:base_project/views/screens/auth/login/login_screen.dart';
import 'package:base_project/views/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:base_project/views/screens/auth/registration/registration_screen.dart';
import 'package:base_project/views/screens/auth/reset_password/reset_password_screen.dart';
import 'package:base_project/views/screens/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:base_project/views/screens/auth/two_factor_screen/two_factor_verification_screen.dart';
import 'package:base_project/views/screens/auth/verify_forget_password/verify_forget_password_screen.dart';
import 'package:base_project/views/screens/deposits/deposit_webview/deposit_payment_webview.dart';
import 'package:base_project/views/screens/deposits/deposits_screen.dart';
import 'package:base_project/views/screens/deposits/new_deposit/new_deposit_screen.dart';
import 'package:base_project/views/screens/home/home_screen.dart';
import 'package:base_project/views/screens/language/language_screen.dart';
import 'package:base_project/views/screens/menu/menu_screen.dart';
import 'package:base_project/views/screens/notification/notification_screen.dart';
import 'package:base_project/views/screens/onboard/onboard_screen.dart';

import 'package:base_project/views/screens/otp_screen/otp_screen.dart';
import 'package:base_project/views/screens/referral/referral_screen.dart';
import 'package:base_project/views/screens/splash/splash_screen.dart';
import 'package:base_project/views/screens/ticket/ticket_details/ticket_details_screen.dart';
import 'package:base_project/views/screens/withdraw/add_withdraw_screen/add_withdraw_method_screen.dart';
import 'package:base_project/views/screens/withdraw/confirm_withdraw_screen/withdraw_confirm_screen.dart';
import 'package:base_project/views/screens/withdraw/withdraw_history/withdraw_screen.dart';

import '../../data/model/auth/login_response_model.dart';
import '../../data/services/push_notification_service.dart';
import '../../views/components/preview_image.dart';
import '../../views/screens/auth/two_factor_screen/two_factor_setup_screen.dart';
import '../../views/screens/ticket/all_ticket_screen.dart';
import '../../views/screens/ticket/new_ticket_screen/new_ticket_screen.dart';
import '../../views/screens/ticket/support_ticket_methods_screen/support_ticket_methods_screen.dart';
import '../helper/shared_preference_helper.dart';

class RouteHelper{

  static const String splashScreen = "/splash";
  static const String bottomNavBar = "/bottom_nav_bar";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String onBoardScreen = "/onboard";
  static const String loginScreen = "/login";
  static const String registrationScreen = "/registration";
  static const String homeScreen = "/home_screen";


  static const String twoFactorScreen          = "/two-factor-screen";
  static const String emailVerificationScreen ='/verify_email' ;
  static const String smsVerificationScreen = '/verify_sms';
  static const String forgetPasswordScreen = '/forget_password' ;
  static const String verifyPassCodeScreen = '/verify_pass_code' ;
  static const String resetPasswordScreen = '/reset_pass' ;
  // static const String twoFactorVerificationScreen = '/two_fa_screen' ;
  static const String privacyScreen='/privacy_screen';

  //account
  static const String profileScreen='/profile';
  static const String editProfileScreen = "/edit_profile";
  static const String profileCompleteScreen='/profile_complete_screen';
  static const String changePasswordScreen='/change_password';

  //notification
  static const String notificationScreen='/notification_screen';

  static const String kycScreen='/kyc_screen';
  static const String menuScreen='/menu_screen';

  //refer screen
  static const String referralScreen = "/referral";


  //deposit
  static const String depositsScreen = "/deposits";
  static const String depositsDetailsScreen = "/deposits_details";
  static const String newDepositScreenScreen = "/deposits_money";
  static const String depositWebViewScreen='/deposit_webView';



  //transfer
  static const String transferScreen = "/transfer";
  static const String wireTransferScreen = "/wire_transfer";
  static const String transferHistoryScreen = "/transfer-history";
  static const String myBankTransferScreen = "/base_project_transfer_icon";
  static const String otherBankTransferScreen = "/other_bank_transfer_screen";


  //withdraw
  static const String withdrawScreen = "/withdraw";
  static const String addWithdrawMethodScreen = "/withdraw_method";

  static const String withdrawOtpScreen = "/withdraw_otp";
  static const String withdrawConfirmScreenScreen = "/withdraw_preview_screen";

  static const String otpScreen = "/otp_screen";

  //fdr screen
  static const String fdrScreen = "/fdr_plan_screen";
  static const String fdrConfirmScreen = "/fdr_confirm_screen";
  static const String timerOtpScreen = "/timer_otp";
  static const String fdrDetailsScreen = "/fdr_details_screen";
  static const String fdrInstallmentLogScreen = "/fdr_installment_log_screen";

  //dps screen
  static const String dpsScreen = "/dps_screen";
  static const String dpsConfirmScreen = "/dps_confirm_screen";
  static const String dpsInstallmentLogScreen = "/dps_installment_log_screen";

  //load screen
  static const String loanScreen = "/loan_plan_screen";
  static const String loanConfirmScreen = "/loan_confirm_screen";
  static const String applyLoanScreen = "/apply_loan";
  static const String loanInstallmentLogScreen = "/loan_installment_log_screen";

  //transaction screen
  static const String transactionScreen = "/transaction";

  //airtime screen
  static const String airtimeScreen        = "/airtime_screen";
  static const String selectOperatorScreen = "/select_operator_screen";

  //privacy policy screen
  static const String termsServicesScreen = "/terms_services";
  static const String faqScreen = "/faq-screen";

  static const String supportTicketMethodsList = '/all_ticket_methods';
  static const String allTicketScreen          = '/all_ticket_screen';
  static const String ticketDetailsdScreen = '/ticket_details_screen';
  static const String newTicketScreen = '/new_ticket_screen';
  static const String previewImageScreen   = "/preview-image-screen";

  static const String languageScreen   = "/language-screen";
  static const String twoFactorSetupScreen   = "/two-factor-setup-screen";


  static List<GetPage> routes = [

    GetPage(name: splashScreen,                   page: () => const SplashScreen()),
    GetPage(name: bottomNavBar,                   page: () => const BottomNavBar()),
    GetPage(name: forgotPasswordScreen,           page: () => const ForgetPasswordScreen()),
    GetPage(name: loginScreen,                    page: () => const LoginScreen()),
    GetPage(name: registrationScreen,             page: () => const RegistrationScreen()),
    GetPage(name: homeScreen,                     page: () => const HomeScreen()),
    GetPage(name: referralScreen,                 page: () => const ReferralScreen()),
    GetPage(name: emailVerificationScreen,        page: () => const EmailVerificationScreen()),
    GetPage(name: smsVerificationScreen,          page: () => SmsVerificationScreen()),
    GetPage(name: forgetPasswordScreen,           page: () => const ForgetPasswordScreen()),
    GetPage(name: verifyPassCodeScreen,           page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen,            page: () => const ResetPasswordScreen()),
    GetPage(name: profileCompleteScreen,          page: () => const ProfileCompleteScreen()),
    GetPage(name: depositsScreen,                 page: () => const DepositsScreen()),
    GetPage(name: newDepositScreenScreen,         page: () => const NewDepositScreen()),
    GetPage(name: withdrawScreen,                 page: () => const WithdrawScreen()),
    GetPage(name: addWithdrawMethodScreen,        page: () => const AddWithdrawMethod()),
    GetPage(name: withdrawConfirmScreenScreen,    page: () => const WithdrawConfirmScreen()),
    GetPage(name: twoFactorScreen, page: () => const TwoFactorVerificationScreen()),

    GetPage(name: editProfileScreen,              page: () => const EditProfileScreen()),
    GetPage(name: changePasswordScreen,           page: () => const ChangePasswordScreen()),
    GetPage(name: menuScreen,                     page: () => const MenuScreen()),
    GetPage(name: profileScreen,                  page: () => const MyProfileScreen()),
    GetPage(name: termsServicesScreen,            page: () => const PrivacyScreen()),
    GetPage(name: notificationScreen,             page: () => const NotificationScreen()),
    GetPage(name: depositWebViewScreen,           page: () => WebViewExample(redirectUrl: Get.arguments)),
    GetPage(name: faqScreen,                      page: () => const FaqScreen()),
    GetPage(name: privacyScreen,                  page: () => const PrivacyScreen()),
    GetPage(name: kycScreen,                      page: () => const KycScreen()),
    GetPage(name: otpScreen,                      page: () => const OtpScreen()),
    // GetPage(name: twoFactorVerificationScreen,    page: () => const TwoFactorVerificationScreen()),

    GetPage(name: supportTicketMethodsList, page: () => const SupportTicketMethodsList()),
    // GetPage(name: communityGroupList, page: () => const OurCommunityGroupList()),
    GetPage(name: allTicketScreen, page: () => const AllTicketScreen()),
    GetPage(name: ticketDetailsdScreen, page: () => const TicketDetailsScreen()),
    GetPage(name: newTicketScreen, page: () => const NewTicketScreen()),
    GetPage(name: previewImageScreen, page: () =>  PreviewImage(url: Get.arguments)),

    GetPage(name: languageScreen, page: () =>  const LanguageScreen()),
    GetPage(name: onBoardScreen, page: () =>  const OnboardScreen()),
    GetPage(name: twoFactorSetupScreen, page: () => const TwoFactorSetupScreen()),

  ];

  static Future<void> checkUserStatusAndGoToNextStep(User? user, {bool isRemember = false,String accessToken = "", String tokenType = ""}) async{

    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = user?.tv == '1' ? false : true;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (isRemember) {
      await sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await sharedPreferences.setString(SharedPreferenceHelper.userIdKey, user?.id.toString() ?? '-1');
    await sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, user?.email ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, user?.mobile ?? '');
    await sharedPreferences.setString(SharedPreferenceHelper.userNameKey, user?.username ?? '');

    if(accessToken.isNotEmpty){
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, accessToken ?? '');
      await sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, tokenType ?? '');
    }

    bool isProfileCompleteEnable = user?.profileComplete == '0' ? true : false;

    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorScreen);
    } else {
      PushNotificationService(apiClient: Get.find()).sendUserToken();
      Get.offAndToNamed(RouteHelper.bottomNavBar,arguments: [true]);
    }
  }

}