class DayOfWeek{
  int dayOfWeek = 0;
  bool checked = false;

  DayOfWeek({this.dayOfWeek = 0, this.checked = false});

  String getTitle(){
    switch(dayOfWeek){
      case 0: return "Понедельник";
      case 1: return "Вторник";
      case 2: return "Среда";
      case 3: return "Четверг";
      case 4: return "Пятница";
      case 5: return "Суббота";
      case 6: return "Воскресенье";
      default: return "Понедельник";
    }
  }
}