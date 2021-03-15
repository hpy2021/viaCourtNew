import 'package:flutter/foundation.dart';
import 'package:my_app/Models/CourtListModel.dart';
class CourtProvider extends ChangeNotifier {
  bool _isHomePageProcessing = true;
  int _currentPage = 1;
  List<CourtListResponse> _courtList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;

  int get currentPage => _currentPage;

  setCurrentPage(int page) {
    _currentPage = page;
  }

  bool get isHomePageProcessing => _isHomePageProcessing;

  setIsHomePageProcessing(bool value) {
    _isHomePageProcessing = value;
    notifyListeners();
  }

  List<CourtListResponse> get courtList => _courtList;

  setCourtListResponsesList(List<CourtListResponse> list, {bool notify = true}) {
    _courtList = list;
    if (notify) notifyListeners();
  }

  mergeCourtListResponsesList(List<CourtListResponse> list, {bool notify = true}) {
    _courtList.addAll(list);
    if (notify) notifyListeners();
  }

  addCourtListResponse(CourtListResponse post, {bool notify = true}) {
    _courtList.add(post);
    if (notify) notifyListeners();
  }

  CourtListResponse getCourtListResponseByIndex(int index) => _courtList[index];

  int get courtListLength => _courtList.length;
}