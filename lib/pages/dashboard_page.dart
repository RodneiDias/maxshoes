import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Wrap(spacing: 20.0, runSpacing: 20.0, children: [
                SizedBox(
                  width: 160.0,
                  height: 160.0,
                  child: Card(
                    color: Color.fromARGB(255, 21, 21, 21),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Image.asset('assets/icons/wallet.png', width: 64.0),
                          SizedBox(height: 10.0),
                          Text(
                            'SALDO',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'Novos Valores',
                            style: TextStyle(
                              color: Colors.white24,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160.0,
                  height: 160.0,
                  child: Card(
                    color: Color.fromARGB(255, 21, 21, 21),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Image.asset('', width: 64.0),
                          SizedBox(height: 10.0),
                          Text(
                            'ALGO',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160.0,
                  height: 160.0,
                  child: Card(
                    color: Color.fromARGB(255, 21, 21, 21),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Image.asset('', width: 64.0),
                          SizedBox(height: 10.0),
                          Text(
                            'ALGO',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160.0,
                  height: 160.0,
                  child: Card(
                    color: Color.fromARGB(255, 21, 21, 21),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Image.asset('', width: 64.0),
                          SizedBox(height: 10.0),
                          Text(
                            'ALGO',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
