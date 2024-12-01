class CricketScore {
  final bool isMatchRunning;
  final String matchId;
  final String teamOne;
  final int teamOneScore;
  final String teamTwo;
  final int teamTwoScore;
  final String winnerTeam;

  CricketScore({
    required this.isMatchRunning,
    required this.matchId,
    required this.teamOne,
    required this.teamOneScore,
    required this.teamTwo,
    required this.teamTwoScore,
    required this.winnerTeam,
  });

  factory CricketScore.fromJson(String id,Map<String, dynamic> json) {
    return CricketScore(
      isMatchRunning: json['isMatchRunning'],
      matchId: id,
      teamOne: json['teamOne'],
      teamOneScore: json['teamOneScore'],
      teamTwo: json['teamTwo'],
      teamTwoScore: json['teamTwoScore'],
      winnerTeam: json['winnerTeam'],
    );
  }
}
