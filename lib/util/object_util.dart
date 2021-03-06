import 'package:footballground/model/time_slot.dart';
import 'package:queries/collections.dart';
import 'package:queries/queries.dart';

class ObjectUtil {
  static Map<int, List<TimeSlot>> mapTimeSlotByDayOfWeek(
      List<TimeSlot> timeSlots) {
    return _mapCollectionToIntMap(
        Collection<TimeSlot>(timeSlots).groupBy((item) => item.dayOfWeek));
  }

  static _mapCollectionToIntMap<T>(IEnumerable<IGrouping<int, T>> item) {
    var result = <int, List<T>>{};
    for (var group in item.asIterable()) {
      result[group.key] = <T>[];
      for (var child in group.asIterable()) {
        result[group.key].add(child);
      }
    }
    return result;
  }

  static _mapCollectionToStringMap<T>(IEnumerable<IGrouping<String, T>> item) {
    var result = <String, List<T>>{};
    for (var group in item.asIterable()) {
      result[group.key] = <T>[];
      for (var child in group.asIterable()) {
        result[group.key].add(child);
      }
    }
    return result;
  }
}
