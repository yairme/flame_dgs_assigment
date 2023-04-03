class FlappyBirdState {
  final int score;
  final int remainingTime;
  final bool isGameOver;

  FlappyBirdState(this.score, this.remainingTime, this.isGameOver);

  FlappyBirdState copyWith({int? score, int? remainingTime, bool? isGameOver}) {
    return FlappyBirdState(
      score ?? this.score,
      remainingTime ?? this.remainingTime,
      isGameOver ?? this.isGameOver,
    );
  }
}
