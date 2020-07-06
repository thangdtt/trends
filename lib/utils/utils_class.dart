import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  Debouncer({this.milliseconds});

  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  run(VoidCallback action) {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

enum CategoryEnum {
  TinNong,
  TinMoi,
  ThoiSu,
  TheGioi,
  KinhDoanh,
  GiaiTri,
  TheThao,
  PhapLuat,
  NhipSongTre,
  VanHoa,
  GiaoDuc,
  SucKhoe,
  DoiSong,
  DuLich,
  KhoaHoc,
  SoHoa,
  Xe,
  GiaThat,
}

Map<CategoryEnum, String> mapCategoryNames = {
  CategoryEnum.TinNong: "Tin nóng",
  CategoryEnum.TinMoi: "Tin mới",
  CategoryEnum.ThoiSu: "Thời sự",
  CategoryEnum.TheGioi: "Thế giới",
  CategoryEnum.KinhDoanh: "Kinh doanh",
  CategoryEnum.GiaiTri: "Giải trí",
  CategoryEnum.TheThao: "Thể thao",
  CategoryEnum.PhapLuat: "Pháp luật",
  CategoryEnum.NhipSongTre: "Nhịp sống trẻ",
  CategoryEnum.VanHoa: "Văn hóa",
  CategoryEnum.GiaoDuc: "Giáo dục",
  CategoryEnum.SucKhoe: "Sức khỏe",
  CategoryEnum.DoiSong: "Đời sống",
  CategoryEnum.DuLich: "Du lịch",
  CategoryEnum.KhoaHoc: "Khoa học",
  CategoryEnum.SoHoa: "Số hóa",
  CategoryEnum.Xe: "Xe",
  CategoryEnum.GiaThat: "Giả - Thật",
};

List<String> tabNames = [
  "Tin nóng",
  "Tin mới",
  "Thời sự",
  "Thế giới",
  "Kinh doanh",
  "Giải trí",
  "Thể thao",
  "Pháp luật",
  "Nhịp sống trẻ"
  "Văn hóa",
  "Giáo dục",
  "Sức khỏe",
  "Đời sống",
  "Du lịch",
  "Khoa học",
  "Số hóa",
  "Xe",
  "Giả - Thật",
];



CategoryEnum mapIndexToCategory(int index, Map<CategoryEnum, bool> tabFilter) {
  int i = 0;
  for (var key in tabFilter.keys) {
    if (tabFilter[key] == true) {
      if (i == index) return key;
      i++;
    }
  }
  return CategoryEnum.TinMoi;
}

Map<CategoryEnum, bool>  loadFilterPrefToMap(List<String> list, Map<CategoryEnum, bool> tabFilter) {
  int i = 0;
  for (var key in tabFilter.keys) {
    if (list[i] == '0')
      tabFilter[key] = false;
    else
      tabFilter[key] = true;
    i++;
  }
  return tabFilter;
}

List<String> tabFilterToList( Map<CategoryEnum, bool> tabFilter) {
  List<String> list = new List();
  for (var value in tabFilter.values) {
    if (value)
      list.add('1');
    else
      list.add('0');
  }
  return list;
}

// Future<bool> checkConnection() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     return true;
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     return true;
//   }
//   return false;
// }
