import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiixplz/cricket_score.dart';
import 'package:flutter/material.dart';

class LiveScoreScreen extends StatefulWidget {
  const LiveScoreScreen({super.key});

  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  // FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('cricket').snapshots();
  final List<CricketScore> _cricketScoreList = [];

  //bool _inProgress = false;

  void _extractData(QuerySnapshot<Object?>? snapshot) {
    _cricketScoreList.clear();
    // final QuerySnapshot snapshot = _firebaseFirestore.collection('cricket').get();
    for (DocumentSnapshot doc in snapshot?.docs ?? []) {
      _cricketScoreList.add(
        CricketScore.fromJson(doc.id, doc.data() as Map<String, dynamic>),

        /// mubham
      );
      // _inProgress = false;
      // setState(() {});
      //_cricketScoreList.add(CricketScore(isMatchRunning: doc.get(''),
      // matchId: matchId,
      // teamOne: teamOne,
      // teamOneScore: teamOneScore,
      // teamTwo: teamTwo,
      // teamTwoScore: teamTwoScore,
      // winnerTeam: winnerTeam))
    }
  }

  Future<void> _refreshData() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('cricket').get();
    setState(() {
      _extractData(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Score App'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CenteredCircularProgressIndicator();
          }
          if (snapshot.hasData) {
            _extractData(snapshot.data);
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: _cricketScoreList.length,
                itemBuilder: (context, index) {
                  CricketScore cricketScore = _cricketScoreList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          _indicatorColor(cricketScore.isMatchRunning),
                      radius: 10,
                    ),
                    title: Text(cricketScore.matchId),
                    // the documents unique id (bangvseng in this case) is gonna be the match id here
                    subtitle: Text('Team 01: ${cricketScore.teamOne} '
                        '\nTeam 02: ${cricketScore.teamTwo}'
                        '\nWinner: ${cricketScore.winnerTeam == '' ? 'Pending' : cricketScore.winnerTeam}'),
                    trailing: Text(
                        '${cricketScore.teamOneScore}/${cricketScore.teamTwoScore}'),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
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
