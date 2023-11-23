extension StringExtention on Duration {
  String get durationFormat {
    return "${this.inHours.toString().length <= 1 ? "0:${this.inHours}" : this.inHours} : ${this.inMinutes.toString().length <= 1 ? "0:${this.inMinutes}" : this.inMinutes} : ${this.inSeconds.toString().length <= 1 ? "0:${this.inSeconds}" : this.inSeconds}";
  }
}
