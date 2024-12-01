import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiixplz/cricket_score.dart';
import 'package:flutter/material.dart';

class LiveScoreScreen extends StatefulWidget {
  const LiveScoreScreen({super.key});

  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<CricketScore> _cricketScoreList = [];
  bool _inProgress = false;


  Future<void> _getScoreData() async {
    _inProgress = true;
    _cricketScoreList.clear();
    final QuerySnapshot snapshot = await _firebaseFirestore.collection('cricket').get();
    for (DocumentSnapshot doc in snapshot.docs) {
      _cricketScoreList.add(
        CricketScore.fromJson(doc.id, doc.data() as Map<String, dynamic>), /// mubham
      );
      _inProgress = false;
      setState(() {});
      //_cricketScoreList.add(CricketScore(isMatchRunning: doc.get(''),
          // matchId: matchId,
          // teamOne: teamOne,
          // teamOneScore: teamOneScore,
          // teamTwo: teamTwo,
          // teamTwoScore: teamTwoScore,
          // winnerTeam: winnerTeam))
    }
  }

  @override
  void initState() {
    super.initState();
    _getScoreData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Score App'),
      ),
      body: Visibility(
        replacement: const CenteredCircularProgressIndicator(),
        visible: !_inProgress,
        child: ListView.builder(
            itemCount: _cricketScoreList.length,
            itemBuilder: (context, index) {
              CricketScore cricketScore = _cricketScoreList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _indicatorColor(cricketScore.isMatchRunning),
                  radius: 10,
                ),
                title: Text(cricketScore.matchId), // the documents unique id (bangvseng in this case) is gonna be the match id here
                subtitle: Text('Team 01: ${cricketScore.teamOne} \nTeam 02: ${cricketScore.teamTwo}'),
                trailing: Text('${cricketScore.teamOneScore}/${cricketScore.teamTwoScore}'),
              );
        },),
      ),
    );
  }

  Color _indicatorColor(bool isMatchRunning) {
    return isMatchRunning ? Colors.green : Colors.grey;
  }
}

class CenteredCircularProgressIndicator extends StatelessWidget {
  const CenteredCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.green,
      ),
    );
  }
}