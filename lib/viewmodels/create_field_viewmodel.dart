import 'package:flutter/cupertino.dart';
import 'package:footballground/models/field.dart';
import 'package:footballground/models/responses/field_resp.dart';
import 'package:footballground/models/time_slot.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/ground_services.dart';
import 'package:footballground/utils/object_util.dart';
import 'package:footballground/utils/string_util.dart';
import 'package:footballground/viewmodels/base_viewmodel.dart';
import 'package:queries/collections.dart';
import 'package:queries/queries.dart';

class CreateFieldViewModel extends BaseViewModel {
  Api _api;
  GroundServices _groundServices;
  double timeStart;
  double timeEnd;
  int numberSlot;
  List<TimeSlot> timeSlots = [];
  Map<int, List<TimeSlot>> timeSlotMap;

  CreateFieldViewModel(
      {@required Api api, @required GroundServices groundServices})
      : _api = api,
        _groundServices = groundServices;

  changeTimeActive(double start, double end) {
    this.timeStart = start;
    this.timeEnd = end;
    generateTimeSlot();
  }

  generateTimeSlot() async {
    numberSlot = ((timeEnd - timeStart) / 1.5).floor();
    timeSlots.clear();
    for (int i = 1; i <= 7; i++) {
      timeSlots.addAll(
        List<TimeSlot>.generate(
          numberSlot,
          (index) => TimeSlot(
              index: index,
              dayOfWeek: i,
              duration: 90,
              startTime: (index * 1.5) + timeStart,
              endTime: (index * 1.5) + timeStart + 1.5,
              price: 0),
        ),
      );
    }
    timeSlotMap = ObjectUtil.mapTimeSlotByDayOfWeek(timeSlots);
    notifyListeners();
  }

  updatePriceItem(int dayOfWeek, int index, String price) {
    // update selected item
    timeSlots[getRealIndex(dayOfWeek, index)].price =
        StringUtil.getPriceFromString(price);
    timeSlots[getRealIndex(dayOfWeek, index)].isFixed = true;

    // update other item unless set price
    for (int i = 1; i <= 7; i++) {
      int realIndex = getRealIndex(i, index);
      if (i != dayOfWeek && !timeSlots[realIndex].isFixed) {
        timeSlots[realIndex].price = StringUtil.getPriceFromString(price);
      }
    }
    notifyListeners();
  }

  int getRealIndex(int dayOfWeek, int index) {
    int startIndex = (dayOfWeek - 1) * numberSlot;
    return startIndex + index;
  }

  Future<FieldResponse> createField(
      int groundId, String fieldName, int type) async {
    Field field = Field(name: fieldName, type: type, timeSlots: timeSlots);
    var resp = await _api.createField(groundId, field);
    if (resp.isSuccess) {}
    return resp;
  }
}
