import 'package:flutter/material.dart';

class PageTheme {
  //////////////////////////////////////////////////////////////////////////////
  // COLORS
  Color appBarColor() {
    return const Color.fromARGB(255, 243, 243, 243);
  }

  Color? cardColor() {
    return Colors.grey[100];
  }

  Color cardColorWhite() {
    return Colors.white;
  }

  Color cardColorBlack() {
    return Colors.black;
  }

  Color searchBarColor() {
    return const Color.fromARGB(255, 228, 228, 228);
  }

  Color pageColor() {
    return Colors.white;
  }

  Color pageColorGrey() {
    return const Color.fromARGB(255, 242, 242, 247);
  }

  Color? bottomNavBarSelectedColor() {
    return Colors.amber[300];
  }

  Color? statusIconColorCompleted() {
    return Colors.green;
  }

  Color? statusIconColorCanceled() {
    return const Color.fromARGB(255, 161, 45, 36);
  }

  Color? statusIconColorIsAvailableToFeedback() {
    return Colors.blue;
  }

  Color? statusIconColorClosedToFeedback() {
    return Colors.grey[600];
  }

  Color? tapBarDividerColor() {
    return Colors.grey[200];
  }

  Color pastelGreen() {
    return const Color.fromARGB(255, 204, 240, 221);
  }

  Color pastelBlue() {
    return const Color.fromARGB(255, 194, 225, 255);
  }

  Color pastelYellow() {
    return const Color.fromARGB(255, 250, 245, 177);
  }

  //////////////////////////////////////////////////////////////////////////////
  //TEXTS
  Text defaultText(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.grey[800]),
    );
  }

  Text appBarTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 20,
          letterSpacing: 0.3),
    );
  }

  Text userNameTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 23,
          letterSpacing: 0.3),
    );
  }

  Text userNameTitleLeft(String title) {
    return Text(
      textAlign: TextAlign.left,
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 23,
          letterSpacing: 0.3),
    );
  }

  Text bodyTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 18,
          letterSpacing: 0.3),
    );
  }

  Text bodyTitleBold(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 18,
          letterSpacing: 0.3),
    );
  }

  Text bodySubtitle(String title) {
    return Text(
      overflow: TextOverflow.fade,
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: 15,
          letterSpacing: 0.3),
    );
  }

  Text bodySubtitleBold(String title) {
    return Text(
      overflow: TextOverflow.fade,
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 15,
          letterSpacing: 0.3),
    );
  }

  Text bodyTitleSettings(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: 17,
          letterSpacing: 0.3),
    );
  }

  Text bodyTitleSettingsRed(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.red,
          fontSize: 17,
          letterSpacing: 0.3),
    );
  }

  Text bodyTitleSettingsWhite(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: 17,
          letterSpacing: 0.3),
    );
  }

  Text timestampText(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.grey[800], fontSize: 12),
    );
  }

  Text defaultTextCenter(String title) {
    return Text(
      title,
      style: defaultTextStyle(),
      textAlign: TextAlign.center,
    );
  }

  TextStyle defaultTextStyle() {
    return TextStyle(color: Colors.grey[800]);
  }

  TextStyle timestampTextStyle() {
    return TextStyle(color: Colors.grey[800], fontSize: 12);
  }

  TextStyle appBarTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 20,
        letterSpacing: 0.3);
  }

  TextStyle userNameTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 23,
        letterSpacing: 0.3);
  }

  Text bodyTitleCenter(String title) {
    return Text(
      title,
      style: bodyTitleTextStyle(),
      textAlign: TextAlign.center,
    );
  }

  TextStyle bodyTitleTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 18,
        letterSpacing: 0.3);
  }

  TextStyle bodyTitleBoldTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 18,
        letterSpacing: 0.3);
  }

  TextStyle bodySubtitleTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 15,
        letterSpacing: 0.3);
  }

  TextStyle bodyTitleSettingsTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 17,
        letterSpacing: 0.3);
  }

  Text titleMessage(String title) {
    return Text(
      title,
      style: titleMessageTextStyle(),
    );
  }

  TextStyle titleMessageTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 20,
        letterSpacing: 0.3);
  }

  TextStyle bodyTitleSettingsRedTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.red,
        fontSize: 17,
        letterSpacing: 0.3);
  }

  TextStyle bodyTitleSettingsWhiteTextStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 17,
        letterSpacing: 0.3);
  }

  //////////////////////////////////////////////////////////////////////////////
  //ELEMENTS
  Divider elementDivider() {
    return Divider(
      color: Colors.grey[900],
      indent: 20,
      endIndent: 20,
      thickness: 2,
      height: 0,
    );
  }

  Divider chatsPageDivider() {
    return Divider(
      color: appBarColor(),
      height: 0.1,
      thickness: 1,
      indent: 70,
    );
  }

  Divider dividerTextFieldSettings() {
    return Divider(
      color: Colors.grey[300],
      indent: 10,
      endIndent: 0,
      thickness: 1,
      height: 0,
    );
  }

  Divider dividerTextFieldSupport() {
    return Divider(
      color: Colors.grey[300],
      indent: 10,
      endIndent: 10,
      thickness: 1,
      height: 0,
    );
  }

  Divider dividerTextFieldIconSettings() {
    return Divider(
      color: Colors.grey[300],
      indent: 50,
      endIndent: 0,
      thickness: 1,
      height: 0,
    );
  }

  Divider divider() {
    return const Divider(
      color: Color.fromARGB(255, 155, 154, 158),
      endIndent: 0,
      thickness: 0.4,
      height: 0,
    );
  }

  Divider dividerCardSettings() {
    return Divider(
      color: appBarColor(),
      indent: 50,
      endIndent: 0,
      thickness: 1,
      height: 0,
    );
  }

  List<Widget> bottomNavBar() {
    return [
      NavigationDestination(
        selectedIcon: Icon(
          Icons.support,
          color: bottomNavBarSelectedColor(),
          size: 32,
        ),
        icon: const Icon(
          Icons.support_outlined,
          size: 32,
        ),
        label: 'Support',
      ),
      NavigationDestination(
        selectedIcon: Icon(
          Icons.home_repair_service,
          color: bottomNavBarSelectedColor(),
          size: 31,
        ),
        icon: const Icon(
          Icons.home_repair_service_outlined,
          size: 31,
        ),
        label: 'Orders',
      ),
      NavigationDestination(
        selectedIcon: Icon(
          Icons.home,
          color: bottomNavBarSelectedColor(),
          size: 38,
        ),
        icon: const Icon(
          Icons.home_outlined,
          size: 38,
        ),
        label: 'Home',
      ),
      NavigationDestination(
        selectedIcon: Icon(
          Icons.forum,
          color: bottomNavBarSelectedColor(),
          size: 30,
        ),
        icon: const Icon(
          Icons.forum_outlined,
          size: 30,
        ),
        label: 'Chats',
      ),
      NavigationDestination(
        selectedIcon: Icon(
          Icons.account_circle,
          color: bottomNavBarSelectedColor(),
          size: 32,
        ),
        icon: const Icon(Icons.account_circle_outlined, size: 32),
        label: 'Account',
      ),
    ];
  }

  ShapeBorder? cardShapeBorderTop() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(0),
    ));
  }

  ShapeBorder? cardShapeBorderCenter() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(0),
      topRight: Radius.circular(0),
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(0),
    ));
  }

  ShapeBorder? cardShapeBorderBottom() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(0),
      topRight: Radius.circular(0),
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ));
  }

  ShapeBorder? cardShapeBorderOnly() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ));
  }

  //////////////////////////////////////////////////////////////////////////////
  //SIZES
  double heightBottomNavBar() {
    return 65;
  }

  //////////////////////////////////////////////////////////////////////////////
  //VALUES
  double elevationAppBarScrolledUnder() {
    return 1;
  }

  double elevationBottomNavBar() {
    return 1;
  }
}
