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

enum categoryEnum {
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

Map<categoryEnum, String> mapCategoryNames = {
  categoryEnum.TinNong: "Tin nóng",
  categoryEnum.TinMoi: "Tin mới",
  categoryEnum.ThoiSu: "Thời sự",
  categoryEnum.TheGioi: "Thế giới",
  categoryEnum.KinhDoanh: "Kinh doanh",
  categoryEnum.GiaiTri: "Giải trí",
  categoryEnum.TheThao: "Thể thao",
  categoryEnum.PhapLuat: "Pháp luật",
  categoryEnum.NhipSongTre: "Nhịp sống trẻ",
  categoryEnum.VanHoa: "Văn hóa",
  categoryEnum.GiaoDuc: "Giáo dục",
  categoryEnum.SucKhoe: "Sức khỏe",
  categoryEnum.DoiSong: "Đời sống",
  categoryEnum.DuLich: "Du lịch",
  categoryEnum.KhoaHoc: "Khoa học",
  categoryEnum.SoHoa: "Số hóa",
  categoryEnum.Xe: "Xe",
  categoryEnum.GiaThat: "Giả - Thật",
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



categoryEnum mapIndexToCategory(int index, Map<categoryEnum, bool> tabFilter) {
  int i = 0;
  for (var key in tabFilter.keys) {
    if (tabFilter[key] == false) {
      if (i == index) return key;
      i++;
    }
  }
  return categoryEnum.TinMoi;
}

Map<categoryEnum, bool>  loadFilterPrefToMap(List<String> list, Map<categoryEnum, bool> tabFilter) {
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

List<String> tabFilterToList( Map<categoryEnum, bool> tabFilter) {
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
