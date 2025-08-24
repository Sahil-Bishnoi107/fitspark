class Exercise {
  String name;
  int calories;
  int sets;
  int time;
  int reps;
  String targetarea;
  String equipment;
  Exercise({required this.name,required this.calories,required this.sets,required this.time,required this.reps,required this.targetarea,required this.equipment});

  factory Exercise.fromJson(Map<String,dynamic> mp){
     String name = mp['name'] ?? "error";
     int calories = mp['calories'] ?? 0;
     int sets = mp['sets'] ?? 1;
     int time = mp['time'] ?? 15;
     int reps = mp['reps'] ?? 10;
     String targetarea = mp['targetarea'] ?? "unknown";
     String equipment = mp['equipment'] ?? "unknown";

     return Exercise(name: name, calories: calories, sets: sets,time:time,reps:  reps,targetarea: targetarea,equipment: equipment);
  }

}
