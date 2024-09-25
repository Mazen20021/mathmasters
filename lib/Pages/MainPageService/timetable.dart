import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myTimetable extends StatelessWidget {
  const myTimetable({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
                child: Text(
              "Time Table",
              style: GoogleFonts.unlock(
                fontSize: screenWidth * 0.03,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            )),
            elevation: 20,
            backgroundColor: const Color.fromARGB(255, 216, 209, 161),
          ),
          body: Column(children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidth,
              child: DataTable(
                columns: const [
                  DataColumn(label: Expanded(child: Text("Class"))),
                  DataColumn(label: Expanded(child: Text("Days"))),
                  DataColumn(label: Expanded(child: Text("Start Time"))),
                  DataColumn(label: Expanded(child: Text("End Time"))),
                  DataColumn(label: Expanded(child: Text("Learning Style")))
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('First Secondary')),
                      DataCell(Text('N/A')),
                      DataCell(Text('N/A')),
                      DataCell(Text('N/A')),
                      DataCell(Text('N/A'))
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Second Secondary')),
                      DataCell(Text('N/A')),
                      DataCell(Text('N/A')),
                      DataCell(Text('N/A')),
                      DataCell(Text('N/A'))
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Third Secondary')),
                      DataCell(Text('Saturday / Tuseday')),
                      DataCell(Text('7:00:00 PM')),
                      DataCell(Text('10:00:00 PM')),
                      DataCell(Text('At Center'))
                    ],
                  ),
                ],
                border: TableBorder.all(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                    style: BorderStyle.solid),
              ),
            )
          ]));
    });
  }
}
