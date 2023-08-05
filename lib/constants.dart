
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/components/LoadingPopup.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(fontFamily: 'Poppins',fontSize: 14),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  // border: Border(
  //   top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  // ),
  
);

const USERS = 'users';
const USER_ROLE_CUSTOMER = 'customer';
const USER_ROLE_DOCTOR = 'doctor';
const POSTS ='posts';
const SETTINGS = 'settings';
const DEPARTMENTS ='departments';
const QUESTIONS = 'questions';
const CITIES = 'cities';

const COLOR_ACCENT = 0xFF8fd468;
const COLOR_PRIMARY_DARK = 0xFF2c7305;
const COLOR_DARK = 0xFF191A1C;
const DARK_COLOR = 0xff191A1C;
const DARK_VIEWBG_COLOR = 0xff191A1C;
const DARK_CARD_BG_COLOR = 0xff242528;
const COLOR_PRIMARY = 0xa575ff;
const FACEBOOK_BUTTON_COLOR = 0xFF415893;
const COUPON_BG_COLOR = 0xFFFCF8F3;
const COUPON_DASH_COLOR = 0xFFCACFDA;
const GREY_TEXT_COLOR = 0xff5E5C5C;

const SECOND_MILLIS = 1000;
const MINUTE_MILLIS = 60 * SECOND_MILLIS;
const HOUR_MILLIS = 60 * MINUTE_MILLIS;

String placeholderImage =
    'https://firebasestorage.googleapis.com/v0/b/hc-morocco-doctors.appspot.com/o/images%2Fusers%2F21954a40-9c42-11ed-b4c2-c159b980e5cc.png?alt=media&token=26ecadd0-16f3-4247-ba31-e655ac0b5bbd';

String getImageVAlidUrl(String url) {
  String imageUrl = placeholderImage;
  if (url != null && url.isNotEmpty) {
    imageUrl = url;
  }
  return imageUrl;
}
