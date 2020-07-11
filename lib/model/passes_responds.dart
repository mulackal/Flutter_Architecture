

class PassData {
  String id;
String user_id;
String name;
String gender;
String age;
String phone;
String personal_id;
String nationality;
String relationship;
String vehicle_no;
String fellow_traveller;
String type;
String going_from;
String going_from_latitude;
String going_from_longitude;
String employer_name;
String employer_address;
String employer_phone_number;
String destination;
String destination_latitude;
String destination_longitude;
String purpose;
String start_time;
String actual_start_time;
String time_of_return;
String actual_time_of_return;
String created_date;
String modified_date;
String is_trip_completed;
String status;
String permanent;


  PassData({this.id, this.user_id, this.name, this.gender, this.age, this.phone,
      this.personal_id, this.nationality, this.relationship, this.vehicle_no,
      this.fellow_traveller, this.type, this.going_from,
      this.going_from_latitude, this.going_from_longitude, this.employer_name,
      this.employer_address, this.employer_phone_number, this.destination,
      this.destination_latitude, this.destination_longitude, this.purpose,
      this.start_time, this.actual_start_time, this.time_of_return,
      this.actual_time_of_return, this.created_date, this.modified_date,
      this.is_trip_completed, this.status, this.permanent});

  PassData.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        user_id = map['user_id'],
        name = map['name'],
        gender = map['gender'],
        age = map['age'],
        phone = map['phone'],
        personal_id = map['personal_id'],
        nationality = map['nationality'],
        relationship = map['relationship'],
        vehicle_no = map['vehicle_no'],
        fellow_traveller = map['fellow_traveller'],
        type = map['type'],
        going_from = map['going_from'],
        going_from_latitude = map['going_from_latitude'],
        going_from_longitude = map['going_from_longitude'],
        employer_name = map['employer_name'],
        employer_address = map['employer_address'],
        employer_phone_number = map['employer_phone_number'],
        destination = map['destination'],
        destination_latitude = map['destination_latitude'],
        destination_longitude = map['destination_longitude'],
        purpose = map['purpose'],
        start_time = map['start_time'],
        actual_start_time = map['actual_start_time'],
        time_of_return = map['time_of_return'],
        actual_time_of_return = map['actual_time_of_return'],
        created_date = map['created_date'],
        modified_date = map['modified_date'],
        is_trip_completed = map['is_trip_completed'],
        status = map['status'],
        permanent = map['permanent'];
}


class PassResponds {

  List<PassData> data;
  String message;
  String status;
  String error;


  PassResponds({this.data, this.message, this.status});

  PassResponds.fromJson(Map<String, dynamic> map)
      : status = map['status'],
        message = map['message'],
        data = (map["data"] as List).map((i) => new PassData.fromJson(i)).toList(),
        error = "";


  PassResponds.withError(String errorValue)
      : data = List(),
        error = errorValue;

}
