import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({Key key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text('Info'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.lightBlue[100],
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: FractionalOffset(0.2, 0.0),
                        child: Text(
                          "National Immunization Programme",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 35, bottom: 0),
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 10),
                            child: Text(
                              "National Immunization Programme (NIP) is the priority 1 (P1) program of Nepal. National immunization program provides equitable services to the geographically, economically hard to reach, marginalized community through more than 16,000 outreach sessions. Currently, 11 antigens are provided through national immunization program.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 3,
                          top: 5,
                        ),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(0.9),
                            1: FlexColumnWidth(2.8),
                            2: FlexColumnWidth(4),
                            3: FlexColumnWidth(1.5),
                          },
                          children: [
                            TableRow(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    'S.N.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' VACCINATION',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                Text(
                                  ' WHAT FOR',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                Text(
                                  ' WHEN',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  ' 1.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Text(
                                  ' BCG',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    'Tuberculosis (क्षयरोग), Diphtheria (भ्यागुते रोग), Pertussis (लहरे खोकी)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 13),
                                  ),
                                ),
                                Text(
                                  ' At birth',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  ' 2.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Text(
                                  'Rota, Polio, FIPV, PCV, DPT, HepB HB 1st ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    'Hepatitis B, Tetanus (धनुषटंकार), Haemophilus influenzae type b, Pneumococcal diseases (meninges, ear and chest infections), Polio',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 13),
                                  ),
                                ),
                                Text(
                                  ' 6 weeks',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  ' 3.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Text(
                                  'Rota, Polio, FIPV, PCV, DPT, HepB HB 2nd ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    'Hepatitis B, Tetanus (धनुषटंकार), Haemophilus influenzae type b, Pneumococcal diseases (meninges, ear and chest infections), Polio',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 13),
                                  ),
                                ),
                                Text(
                                  ' 10 weeks',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  ' 4.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Text(
                                  'Rota, Polio, FIPV, PCV, DPT, HepB HB 3rd',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    'Hepatitis B, Tetanus (धनुषटंकार), Haemophilus influenzae type b, Pneumococcal diseases (meninges, ear and chest infections), Polio',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 13),
                                  ),
                                ),
                                Text(
                                  ' 14 weeks and 9 months(PCV)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  ' 5.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Text(
                                  'PCV, Measles-Rubella',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    'Measles (चेचक) and Rubella (German measles)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 13),
                                  ),
                                ),
                                Text(
                                  ' 9 months',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  ' 6.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    'Japanese Encephalitis ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 13),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 7),
                                  child: Text(
                                    'Japanese Encephalitis ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 13),
                                  ),
                                ),
                                Text(
                                  ' 12 months',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  ' 7.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Text(
                                  'Measles-Rubella',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Measles (चेचक) and Rubella (German measles)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 13),
                                  ),
                                ),
                                Text(
                                  ' 15 months',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
