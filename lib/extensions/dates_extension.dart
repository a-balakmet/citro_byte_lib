extension Dates on DateTime {

  String stringDDmm() {
    String day = this.day < 10 ? '0${this.day}' : '${this.day}';
    String month = this.month < 10 ? '0${this.month}' : '${this.month}';
    return '$day.$month';
  }
}
