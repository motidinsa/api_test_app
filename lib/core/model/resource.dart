class Resource{
  late String name;
  late int year;
  late String color;
  late String pantoneValue;
  Resource({required this.color,required this.year,required this.name,required this.pantoneValue});

  Resource.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    year = json['year'];
    pantoneValue = json['pantone_value'];
  }
}