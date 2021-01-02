import 'package:tales/config/constants/asset_constants.dart';
import 'package:tales/model/tale.dart';

class LocalTaleServices {
  List<Tale> talesList = <Tale>[
    Tale(
      0,
      "Kazlar ve İncir Ağacı",
      AssetConstants.TALE_IMG_URL + "1.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "1.mp3",
      49.0,
    ),
    Tale(
      1,
      "Çocuk ve Doğa",
      AssetConstants.TALE_IMG_URL + "2.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "2.mp3",
      58.0,
    ),
    Tale(
      2,
      "Eşek ve Keçi",
      AssetConstants.TALE_IMG_URL + "3.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "3.mp3",
      52.0,
    ),
    Tale(
      3,
      "Karga ile Kartal",
      AssetConstants.TALE_IMG_URL + "4.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "4.mp3",
      48.0,
    ),
    Tale(
      4,
      "Aslan, Tilki ve Eşek",
      AssetConstants.TALE_IMG_URL + "5.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "5.mp3",
      38.0,
    ),
  ];

  List<Tale> getAllTales() {
    return talesList;
  }
}

/* List<Tale> talesList = <Tale>[
    Tale(
      0,
      "Kazlar ve İncir Ağacı",
      AssetConstants.TALE_IMG_URL + "1.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "1.mp3",
      186.0,
    ),
    Tale(
      1,
      "Çocuk ve Doğa",
      AssetConstants.TALE_IMG_URL + "2.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "2.mp3",
      87.0,
    ),
    Tale(
      2,
      "Eşek ve Keçi",
      AssetConstants.TALE_IMG_URL + "3.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "3.mp3",
      113.0,
    ),
    Tale(
      3,
      "Karga ile Kartal",
      AssetConstants.TALE_IMG_URL + "4.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "4.mp3",
      49.0,
    ),
    Tale(
      4,
      "Aslan, Tilki ve Eşek",
      AssetConstants.TALE_IMG_URL + "5.png",
      "Emir",
      AssetConstants.TALE_SOUND_URL + "5.mp3",
      57.0,
    ),
  ]; */
