import 'package:flutter/cupertino.dart';

import '../models/random_user_list_res.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class HomeViewModel extends ChangeNotifier{
  bool isLoading = false;
  List<RandomUser> userList = [];
  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  loadRandomUserList() async {
    isLoading = true;
    notifyListeners();

    var response = await Network.GET(Network.API_RANDOM_USER_LIST,
        Network.paramsRandomUserList(currentPage));
    LogService.i(response!);
    var randomUserListRes = Network.parseRandomUserList(response);
    currentPage = randomUserListRes.info.page + 1;

      userList.addAll(randomUserListRes.results);
      isLoading = false;
      notifyListeners();
  }


}