import 'package:flutter/material.dart';

class homecontroller extends ChangeNotifier {

int selectedBottomTab=0; 
void onBottomNavigatorTabChange(int index){
  selectedBottomTab=index;
  notifyListeners();
}

  bool isRightdoorlock = true;
  bool isleftdoorlock=true;
  bool istopdoorlock=true;
  bool isbottomdoorlock=true; 
   void updateRightdoorlock() {
    isRightdoorlock = !isRightdoorlock;
  notifyListeners();
  }
  void updateleftdoorlock(){
    isleftdoorlock=!isleftdoorlock;
    notifyListeners();
  }
  void updatetopdoorlock(){
    istopdoorlock=!istopdoorlock;
    notifyListeners();
    }
    void updatebottomdoorlock(){
      isbottomdoorlock=!isbottomdoorlock;
      notifyListeners();
    }
    bool isCoolSelected=true;
    void updateCoolSelectedTab() {
      isCoolSelected=!isCoolSelected;
      notifyListeners();
    }
    bool isShowTyre=false;
    void showTyreController(int index){
      if(selectedBottomTab!=3 && index==3){
        Future.delayed(const Duration(milliseconds: 400),(){
isShowTyre=true;
        notifyListeners();
        });
      }else{
        isShowTyre=false;
        notifyListeners();
      }
    }
    bool isShowTyreStatus=false;
    void tyreStatusController(int index){
      if(selectedBottomTab!=3 && index==3){
        isShowTyreStatus=true;
        notifyListeners();
      }else{
          isShowTyreStatus=false;
          notifyListeners();
      }
    }
}
