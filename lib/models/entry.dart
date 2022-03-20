class Entry {
  int id;
  String date;
  String time;
  int mood;
  int sleep;
  int iritability;
  Medication medication;
  Diet diet;
  String exercise;
  String notes;

  Entry({
    this.id,
    this.date,
    this.time,
    this.mood,
    this.sleep,
    this.iritability,
    this.medication,
    this.diet,
    this.exercise,
    this.notes,
  });

  // ignore: empty_constructor_bodies
  factory Entry.fromJSON(json) {
    if (json.isNotEmpty) {
      return Entry(
        id: json['_id'],
        date: json['date'],
        time: json['time'],
        mood: json['mood'],
        sleep: json['sleep'],
        iritability: json['iritability'],
        medication: Medication(
          name: json['medication'][0]['name'],
          dose: json['medication'][0]['dose'],
        ),
        diet: Diet(
          food: json['diet'][0]['food'],
          amount: json['diet'][0]['amount'],
        ),
        exercise: json['exercise'],
        notes: json['notes'],
      );
    } else {
      return null;
    }
  }
}

class Medication {
  String name;
  String dose;

  Medication({
    this.name,
    this.dose,
  });
}

class Diet {
  String food;
  String amount;

  Diet({
    this.food,
    this.amount,
  });
}
