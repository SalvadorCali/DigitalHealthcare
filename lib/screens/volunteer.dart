import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:thesis/constants.dart';
import 'package:thesis/model/patient.dart';
import 'package:thesis/model/searched_patient.dart';
import 'package:thesis/services/pdf_handler.dart';
import 'package:thesis/widgets/appbar_button.dart';
import 'package:thesis/widgets/volunteer_card.dart';
import 'package:unicorndial/unicorndial.dart';

class Volunteer extends StatefulWidget {
  final List<Patient> patients;
  final changeScreen;
  const Volunteer(this.patients, this.changeScreen);

  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  List<String> qrCodeDataList = [];
  List<String> namesList = [];
  List<String> dateList = [];
  List<SearchedPatient> patients = [];
  List<SearchedPatient> queryResult = [];
  List<SearchedPatient> bodyPatients = [];
  bool loading = false;

  @override
  void initState() {
    _initializePatient();
    super.initState();
  }

  _initializePatient() {
    setState(() {
      widget.patients.forEach((element) {
        patients.add(SearchedPatient(element, false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: bodyPatients.length > 1
            ? _buildFloatingButton()
            : SizedBox.shrink(),
        appBar: AppBar(
          title: Text("Homepage"),
          actions: [
            AppBarButton(Icon(Icons.logout), widget.changeScreen),
          ],
        ),
        body: loading
            //? Center(child: Text("Generazione PDF..."))
            ? LinearProgressIndicator()
            : _searchScreen());
  }

  Widget _searchScreen() {
    return Stack(fit: StackFit.expand, children: [
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 66,
            ),
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: bodyPatients.length,
                itemBuilder: (context, index) {
                  return bodyPatients[index].body
                      ? VolunteerCard(bodyPatients[index].patient, index,
                          _setDate, _removeElement)
                      : SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
      _buildSearchBar(),
    ]);
  }

  FloatingSearchBar _buildSearchBar() {
    return FloatingSearchBar(
      hint: 'Cerca...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      width: MediaQuery.of(context).size.width,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        if (query != "") {
          setState(() {
            queryResult = patients
                .where((element) =>
                    element.patient.fullName
                        .toLowerCase()
                        .contains(query.toLowerCase()) ||
                    element.patient.tin
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .toList();
          });
        }
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...createQueryResults(),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> createQueryResults() {
    List<Widget> widgets = [];
    queryResult.forEach((element) {
      widgets.add(ListTile(
        title: Text(element.patient.fullName),
        subtitle: Text(element.patient.tin),
        trailing: element.body
            ? SizedBox.shrink()
            : ElevatedButton(
                onPressed: () {
                  setState(() {
                    element.body = true;
                    bodyPatients.add(element);
                    namesList.add(element.patient.fullName);
                    dateList.add(element.patient.data.keys.last);
                  });
                },
                child: Text("Aggiungi")),
      ));
    });
    return widgets;
  }

  _setDate(int index, String newDate) {
    setState(() {
      dateList[index] = newDate;
    });
  }

  _removeElement(String tin) {
    bool exit = false;
    for (int i = 0; i < bodyPatients.length; i++) {
      if (bodyPatients[i].patient.tin == tin) {
        setState(() {
          patients.forEach((member) {
            if (member.patient.tin == tin) {
              member.body = false;
            }
          });
          bodyPatients.remove(bodyPatients[i]);
          namesList.remove(namesList[i]);
          dateList.remove(dateList[i]);
          exit = true;
        });
        if (exit) break;
      }
    }
  }

  Widget _buildFloatingButton() {
    return UnicornDialer(
      parentButton: Icon(Icons.print),
      childButtons: [
        UnicornButton(
          currentButton: FloatingActionButton(
            mini: true,
            onPressed: generateMultipleBadge,
            child: icons[1],
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            mini: true,
            onPressed: generateMultipleCIS,
            child: icons[2],
          ),
        ),
        UnicornButton(
          currentButton: FloatingActionButton(
            mini: true,
            onPressed: generateMultipleBracelet,
            child: icons[3],
          ),
        )
      ],
    );
  }

  generateMultipleBadge() {
    Future.delayed(Duration(seconds: 1), () async {
      _createData();
      await PDFHandler(qrDataList: qrCodeDataList)
          .openMultipleBadge()
          .whenComplete(() {
        _resetData();
      });
    });
  }

  generateMultipleCIS() {
    Future.delayed(Duration(seconds: 1), () async {
      _createData();
      await PDFHandler(qrDataList: qrCodeDataList)
          .openMultipleCIS()
          .whenComplete(() {
        _resetData();
      });
    });
  }

  task() {
    compute(generateMultipleBracelet(), "ok");
  }

  generateMultipleBracelet() async {
    _createData();
    await PDFHandler(
            qrDataList: qrCodeDataList,
            names: namesList,
            setLoading: _setLoading)
        .openMultipleBracelet()
        .whenComplete(() {
      _resetData();
    });
    //qrCodeDataList.clear();
  }

  _createData() {
    setState(() {
      loading = true;
    });
    for (int i = 0; i < bodyPatients.length; i++) {
      qrCodeDataList.add(
          bodyPatients[i].patient.data[dateList[i]].getLifeSavingInformation());
    }
  }

  _resetData() {
    qrCodeDataList.clear();
    setState(() {
      loading = false;
    });
  }

  _setLoading() {
    setState(() {
      loading = false;
    });
  }
}
