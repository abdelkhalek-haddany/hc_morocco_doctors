import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../constants.dart';
class User with ChangeNotifier {
  String email;

  String firstName;

  String lastName;

  UserSettings settings;

  String phoneNumber;

  bool active;

  Timestamp lastOnlineTimestamp;

  String userID;

  String profilePictureURL;

  String appIdentifier;

  String fcmToken;

  UserLocation location;

  String? stripeCustomer;

  String role;

  String carName;

  String carNumber;

  String carPictureURL;

  String? inProgressOrderID;

  dynamic wallet_amount;

  User(
      {this.email = '',
        this.userID = '',
        this.profilePictureURL = '',
        this.firstName = '',
        this.phoneNumber = '',
        this.lastName = '',
        this.active = true,
        this.wallet_amount = 0.0,
        lastOnlineTimestamp,
        settings,
        this.fcmToken = '',
        location,
        shippingAddress,
        this.stripeCustomer,
        this.role = USER_ROLE_DOCTOR,
        this.carName = '',
        this.carNumber = '',
        this.carPictureURL = '',
        this.inProgressOrderID = '',
        })
      : this.lastOnlineTimestamp = lastOnlineTimestamp ?? Timestamp.now(),
        this.settings = settings ?? UserSettings(),
        this.appIdentifier = 'HC MOROCCO DOCTORS ${Platform.operatingSystem}',
        this.location = location ?? UserLocation();

  String fullName() {
    return ((email == null || email.isEmpty) && (phoneNumber == null || phoneNumber.isEmpty)) ? 'Login to Manage' : '$firstName $lastName';
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        wallet_amount: parsedJson['wallet_amount'] ?? 0.0,
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        active: parsedJson['active'] ?? true,
        lastOnlineTimestamp: parsedJson['lastOnlineTimestamp'],
        settings: parsedJson.containsKey('settings') ? UserSettings.fromJson(parsedJson['settings']) : UserSettings(),
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        fcmToken: parsedJson['fcmToken'] ?? '',
        location: parsedJson.containsKey('location') ? UserLocation.fromJson(parsedJson['location']) : UserLocation(),
        stripeCustomer: parsedJson['stripeCustomer'] ?? null,
        role: parsedJson['role'] ?? '',
        carName: parsedJson['carName'] ?? '',
        carNumber: parsedJson['carNumber'] ?? '',
        carPictureURL: parsedJson['carPictureURL'] ?? '',
    );
  }

  factory User.fromPayload(Map<String, dynamic> parsedJson) {
    return User(
        wallet_amount: parsedJson['wallet_amount'] ?? 0.0,
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        active: parsedJson['active'] ?? true,
        lastOnlineTimestamp: Timestamp.fromMillisecondsSinceEpoch(parsedJson['lastOnlineTimestamp']),
        settings: parsedJson.containsKey('settings') ? UserSettings.fromJson(parsedJson['settings']) : UserSettings(),
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '',
        fcmToken: parsedJson['fcmToken'] ?? '',
        location: parsedJson.containsKey('location') ? UserLocation.fromJson(parsedJson['location']) : UserLocation(),
        stripeCustomer: parsedJson['stripeCustomer'] ?? '',
        role: parsedJson['role'] ?? '',
        carName: parsedJson['carName'] ?? '',
        carNumber: parsedJson['carNumber'] ?? '',
        carPictureURL: parsedJson['carPictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'wallet_amount': this.wallet_amount,
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'settings': this.settings.toJson(),
      'phoneNumber': this.phoneNumber,
      'id': this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp,
      'profilePictureURL': this.profilePictureURL,
      'appIdentifier': this.appIdentifier,
      'fcmToken': this.fcmToken,
      'location': this.location.toJson(),
      'stripeCustomer': this.stripeCustomer,
      'role': this.role
    };
    if (this.role == USER_ROLE_DOCTOR) {
      json.addAll({
        'role': this.role,
        'carName': this.carName,
        'carNumber': this.carNumber,
        'carPictureURL': this.carPictureURL,
      });
    }
    return json;
  }

  Map<String, dynamic> toPayload() {
    Map<String, dynamic> json = {
      'wallet_amount': this.wallet_amount,
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'settings': this.settings.toJson(),
      'phoneNumber': this.phoneNumber,
      'id': this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp.millisecondsSinceEpoch,
      'profilePictureURL': this.profilePictureURL,
      'appIdentifier': this.appIdentifier,
      'fcmToken': this.fcmToken,
      'location': this.location.toJson(),
      'stripeCustomer': this.stripeCustomer,
      'role': this.role
    };
    if (this.role == USER_ROLE_DOCTOR) {
      json.addAll({
        'role': this.role,
        'carName': this.carName,
        'carNumber': this.carNumber,
        'carPictureURL': this.carPictureURL,
      });
    }
    return json;
  }
}

class UserSettings {
  bool pushNewMessages;

  bool orderUpdates;

  bool newArrivals;

  bool promotions;

  UserSettings({this.pushNewMessages = true, this.orderUpdates = true, this.newArrivals = true, this.promotions = true});

  factory UserSettings.fromJson(Map<dynamic, dynamic> parsedJson) {
    return UserSettings(
      pushNewMessages: parsedJson['pushNewMessages'] ?? true,
      orderUpdates: parsedJson['orderUpdates'] ?? true,
      newArrivals: parsedJson['newArrivals'] ?? true,
      promotions: parsedJson['promotions'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNewMessages': this.pushNewMessages,
      'orderUpdates': this.orderUpdates,
      'newArrivals': this.newArrivals,
      'promotions': this.promotions,
    };
  }
}

class UserLocation {
  double latitude;
  double longitude;

  UserLocation({this.latitude = 0.01, this.longitude = 0.01});

  factory UserLocation.fromJson(Map<dynamic, dynamic> parsedJson) {
    return UserLocation(
      latitude: parsedJson['latitude'] ?? 00.1,
      longitude: parsedJson['longitude'] ?? 00.1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }
}
