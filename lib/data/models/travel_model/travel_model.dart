

class TypesMapper {
  static TravelType travelTypeParse(String title) {
    switch (title.toLowerCase()) {
      case 'Vacation':
        return TravelType.Vacation;
      case 'Work':
        return TravelType.Work;
      case 'Other':
        return TravelType.Other;
      default:
        throw ArgumentError('Invalid type: $title');
    }
  }
}

enum TravelType { Vacation, Work, Other }

class TravelModel {
  final String countryName;
  final String comment;
  final DateTime startDate;
  final DateTime endDate;
  final String companion;
  final String transport;
  final TravelType travelType;
  final double travelBudget;

  TravelModel( {
    required this.countryName,
    required this.comment,
    required this.companion,
    required this.transport,
    required this.travelType,
    required this.travelBudget,
    required this.startDate,
    required this.endDate,
  });


  Map<String, dynamic> toJson() {
    return {
      'countryName': countryName,
      'comment': comment,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'companion': companion,
      'transport': transport,
      'travelType': travelType.index,
      'travelBudget': travelBudget,
    };
  }

  static TravelModel fromJson(Map<String, dynamic> json) {
    return TravelModel(
      countryName: json['countryName'],
      comment: json['comment'],
      companion: json['companion'],
      transport: json['transport'],
      travelType: TravelType.values[json['travelType']],
      travelBudget: json['travelBudget'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}
