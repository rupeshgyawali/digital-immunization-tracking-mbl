import 'package:flutter/material.dart';

import '../../child/screens/local/header_section.dart';

class NationalImmunizationProgrammeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCDCDC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      "National Immunization Programme",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "National Immunization Programme (NIP) is the priority 1 (P1) program of Nepal. National immunization program provides equitable services to the geographically, economically hard to reach, marginalized community through more than 16,000 outreach sessions. Currently, 11 antigens are provided through national immunization program.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: VaccineTable(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VaccineTable extends StatelessWidget {
  const VaccineTable({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
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
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              ' VACCINATION',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
            ),
            Text(
              ' WHAT FOR',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
            ),
            Text(
              ' WHEN',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15),
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
                  fontSize: 14),
            ),
            Text(
              ' BCG',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 7),
              child: Text(
                'Tuberculosis (क्षयरोग), Diphtheria (भ्यागुते रोग), Pertussis (लहरे खोकी)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14),
              ),
            ),
            Text(
              ' At birth',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
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
                  fontSize: 14),
            ),
            Text(
              'Rota, Polio, FIPV, PCV, DPT, HepB HB 1st ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 7),
              child: Text(
                'Hepatitis B, Tetanus (धनुषटंकार), Haemophilus influenzae type b, Pneumococcal diseases (meninges, ear and chest infections), Polio',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14),
              ),
            ),
            Text(
              ' 6 weeks',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
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
                  fontSize: 14),
            ),
            Text(
              'Rota, Polio, FIPV, PCV, DPT, HepB HB 2nd ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 7),
              child: Text(
                'Hepatitis B, Tetanus (धनुषटंकार), Haemophilus influenzae type b, Pneumococcal diseases (meninges, ear and chest infections), Polio',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14),
              ),
            ),
            Text(
              ' 10 weeks',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
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
                  fontSize: 14),
            ),
            Text(
              'Rota, Polio, FIPV, PCV, DPT, HepB HB 3rd',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 7),
              child: Text(
                'Hepatitis B, Tetanus (धनुषटंकार), Haemophilus influenzae type b, Pneumococcal diseases (meninges, ear and chest infections), Polio',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14),
              ),
            ),
            Text(
              ' 14 weeks and 9 months(PCV)',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
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
                  fontSize: 14),
            ),
            Text(
              'PCV, Measles-Rubella',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 7),
              child: Text(
                'Measles (चेचक) and Rubella (German measles)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14),
              ),
            ),
            Text(
              ' 9 months',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
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
                  fontSize: 14),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 7),
              child: Text(
                'Japanese Encephalitis ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 7),
              child: Text(
                'Japanese Encephalitis ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14),
              ),
            ),
            Text(
              ' 12 months',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
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
                  fontSize: 14),
            ),
            Text(
              'Measles-Rubella',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Measles (चेचक) and Rubella (German measles)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 14),
              ),
            ),
            Text(
              ' 15 months',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
