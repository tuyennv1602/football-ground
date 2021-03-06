import 'package:footballground/model/time_slot.dart';

class Field {
  int id;
  int status;
  String name;
  int type;
  int tickets;
  int createDate;
  int groundId;
  List<TimeSlot> timeSlots;

  Field(
      {this.id,
      this.status,
      this.name,
      this.type,
      this.tickets,
      this.createDate,
      this.groundId,
      this.timeSlots});

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    type = json['type'];
    tickets = json['tickets'];
    createDate = json['create_date'];
    groundId = json['ground_id'];
    if (json['time_slots'] != null) {
      timeSlots = new List<TimeSlot>();
      json['time_slots'].forEach((v) {
        timeSlots.add(new TimeSlot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['type'] = this.type;
    data['tickets'] = this.tickets;
    data['create_date'] = this.createDate;
    data['ground_id'] = this.groundId;
    if (this.timeSlots != null) {
      data['time_slots'] = this.timeSlots.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.timeSlots != null) {
      data['time_slots'] = this.timeSlots.map((v) => v.toCreateJson()).toList();
    }
    return data;
  }
}
