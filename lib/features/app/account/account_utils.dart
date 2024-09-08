import 'package:b2clients/features/entrance/entrance_page.dart';
import 'package:b2clients/services/simple_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase_utils.dart';

class AccountUtils {
  FirebaseUtils firebaseUtils = FirebaseUtils();
  SimpleUtils simpleUtils = SimpleUtils();
  // get firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  // GET USER STREAM
  Stream<Map<String, dynamic>?> getUserStream() {
    return _firestore
        .collection("accounts")
        .doc(currentUser.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.data();
    });
  }

  // UPDATE USER NAME AND SURNAME
  Future updateNameAndSurname(TextEditingController nameController,
      TextEditingController surnameController) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    firebaseUtils.updateUserAccountData({
      'name': nameController.text,
      'surname': surnameController.text,
      'update_time': Timestamp.now()
    });

    currentUser.updateDisplayName(
        '${nameController.text.trim()} ${surnameController.text.trim()}');
  }

  // CHANGE USER EMAIL
  Future changeEmail(TextEditingController passwordController,
      TextEditingController emailController, BuildContext context) async {
    var credential = EmailAuthProvider.credential(
        email: currentUser.email.toString(), password: passwordController.text);
    var result = await currentUser.reauthenticateWithCredential(credential);
    await result.user?.verifyBeforeUpdateEmail(emailController.text);
    await FirebaseAuth.instance.signOut();
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EntrancePage()),
    );
  }

  // CHANGE PHONE NUMBER
  Future updatePhoneNumber() async {
    String? phone = FirebaseAuth.instance.currentUser!.phoneNumber.toString();

    await firebaseUtils.updateUserAccountData({'phone_number': phone});
  }

  // ADDRESS FROM LIST TO STRING
  String getAddressString(List addresses) {
    int counter = 0;
    String addressesString = '';
    if (addressesString.toString().isEmpty) {
      for (var element in addresses) {
        if (counter == addresses.length - 1) {
          addressesString += simpleUtils.toTitleCase(element);
          counter++;
        } else {
          addressesString += '${simpleUtils.toTitleCase(element)}, ';
          counter++;
        }
      }
    }
    return addressesString;
  }

  //CHANGE LANGUAGE
  Future changeLanguage(languageCode) async {
    firebaseUtils.updateUserAccountData({'language_code': languageCode});
  }

  //////////////////////////////// LANGUAGES

  Map languages = {
    "af": "African",
    "ak": "Akan",
    "am": "Amharic",
    "ar": "Arabic",
    "as": "Assamese",
    "ay": "Aymara",
    "az": "Azeri",
    "be": "Belarusian",
    "bg": "Bulgarian",
    "bm": "Bambara",
    "bn": "Bengali",
    "bs": "Bosnian",
    "ca": "Catalan",
    "co": "Corsican",
    "cs": "Czech",
    "cy": "Welsh",
    "da": "Danish",
    "de": "German",
    "dv": "Divehi",
    "ee": "Ewe",
    "el": "Greek",
    "en": "English",
    "eo": "Esperanto",
    "es": "Spanish",
    "et": "Estonian",
    "eu": "Basque",
    "fa": "Farsi",
    "fi": "Finnish",
    "fr": "French",
    "fy": "Frisian",
    "ga": "Irish",
    "gd": "Gaelic",
    "gl": "Galician",
    "gn": "Guarani",
    "gu": "Gujarati",
    "ha": "Hausa",
    "hi": "Hindi",
    "hr": "Croatian",
    "ht": "Haitian",
    "hu": "Hungarian",
    "hy": "Armenian",
    "id": "Indonesian",
    "ig": "Igbo",
    "is": "Icelandic",
    "it": "Italian",
    "iw": "Hebrew",
    "ja": "Japanese",
    "jw": "Javanese",
    "ka": "Georgian",
    "kk": "Kazakh",
    "km": "Cambodian",
    "kn": "Kannada",
    "ko": "Korean",
    "ku": "Kurdish",
    "ky": "Kirghiz",
    "la": "Latin",
    "lb": "Luxembourgish",
    "lg": "Ganda",
    "lo": "Laothian",
    "lt": "Lithuanian",
    "lv": "Latvian",
    "mg": "Malagasy",
    "mi": "Maori",
    "mk": "Macedonian",
    "ml": "Malayalam",
    "mn": "Mongolian",
    "mr": "Marathi",
    "ms": "Malay",
    "mt": "Maltese",
    "my": "Burmese",
    "ne": "Nepali (India)",
    "nl": "Dutch",
    "no": "Norwegian",
    "ny": "Chichewa",
    "om": "(Afan)/Oromoor/Oriya",
    "or": "Oriya",
    "pa": "Punjabi",
    "pl": "Polish",
    "ps": "Pashto/Pushto",
    "pt": "Portuguese",
    "qu": "Quechua",
    "ro": "Romanian",
    "ru": "Russian",
    "rw": "Kinyarwanda",
    "sa": "Sanskrit",
    "sd": "Sindhi",
    "si": "Singhalese",
    "sk": "Slovak",
    "sl": "Slovenian",
    "sm": "Samoan",
    "sn": "Shona",
    "so": "Somali",
    "sq": "Albanian",
    "sr": "Serbian",
    "st": "Sesotho",
    "su": "Sundanese",
    "sv": "Swedish",
    "sw": "Swahili",
    "ta": "Tamil",
    "te": "Telugu",
    "tg": "Tajik",
    "th": "Thai",
    "ti": "Tigrinya",
    "tk": "Turkmen",
    "tl": "Tagalog",
    "tr": "Turkish",
    "ts": "Tsonga",
    "tt": "Tatar",
    "ug": "Uyghur",
    "uk": "Ukrainian",
    "ur": "Urdu",
    "uz": "Uzbek",
    "vi": "Vietnamese",
    "xh": "Xhosa",
    "yi": "Yiddish",
    "yo": "Yoruba",
    "zh-cn": "Chinese (China)",
    "zh-tw": "Chinese (Taiwan)",
    "zu": "Zulu"
  };

  List translatedLanguages = [
    'Afrikaans',
    'Akan',
    'አማርኛ',
    'اللغة العربية',
    'অসমিয়া',
    'Aymar aru',
    'آذری',
    'Беларуская мова',
    'Български език',
    'Bamanankan',
    'বাংলা',
    'Bosanski jezik',
    'Català',
    'Corsu/Corso/Corse/Corsi',
    'Čeština',
    'Cymraeg',
    'Dansk',
    'Deutsch',
    'ދިވެހި',
    'Eʋe',
    'Ελληνικά',
    'English',
    'Esperanto',
    'Español',
    'Eesti keel',
    'Euskaldunak',
    'زبان فارسی',
    'Suomi',
    'Le français',
    'Frysk',
    'Gaeilge',
    'Gàidhlig',
    'Galego',
    "ava-ñe'ẽ",
    'ગુજરાતી',
    'Harshen',
    'हिन्दी',
    'Hrvatski jezik',
    'Kreyòl ayisyen',
    'Magyar',
    'հայերեն ',
    'Bahasa Indonesia',
    'Igbo',
    'íslenska',
    'Italiano',
    'עברית',
    '日本語',
    'ꦧꦱ ꦗꦮ',
    'ქართული ენა',
    'қазақ',
    'ភាសាខ្មែរ',
    'ಕನ್ನಡ',
    '한국어, 韓國語',
    'زمانێ كوردی',
    'Кыргыз тили',
    'Lingua Latina',
    'Lëtzebuergesch',
    'Baganda',
    'ພາສາລາວ',
    'Lietùvių kalbà',
    'Latviešu valoda',
    'مـَلـَغـَسـِ',
    'Māori',
    'Mакедонски јазик',
    'മലയാളം',
    'Монгол хэл',
    'मराठी',
    'Bahasa Melayu',
    'Malti',
    'ဗမာစာ',
    'नेपाली',
    'de Nederlandse taal',
    'Norsk',
    'Nyanja',
    '(Afan)/Oromoor/Oriya',
    'ଓଡ଼ିଆ',
    'Punjabi',
    'Polski',
    'پښتو',
    'Português',
    'Qhichwa simi',
    'Limba română',
    'Русский',
    'Kinyarwanda',
    'संस्कृत',
    'सिन्धी',
    'සිංහල',
    'Slovenský jazyk',
    'Slovenski jezik',
    'gagana Sāmoa',
    'chiShona',
    '𐒖𐒍 𐒈𐒝𐒑𐒛𐒐𐒘',
    'Shqip',
    'Srpski jezik',
    'Sesotho sa Leboa',
    'Basa Sunda',
    'Svenska',
    'Waswahili',
    'தமிழ்',
    'తెలుగు',
    'زبان تاجیکی',
    'ภาษาไทย',
    'ትግርኛ',
    'Türkmen dili',
    'Tagalog',
    'Türkçe',
    'Xitsonga',
    'تاتار تلی',
    'Уйғурчә',
    'Українська мова',
    'اردو',
    'Оʻzbek tili',
    'Tiếng Việt',
    'isiXhosa',
    'אידיש',
    'Yorùbá',
    '中文',
    '官話 [官话]',
    'bi zule',
  ];
}
