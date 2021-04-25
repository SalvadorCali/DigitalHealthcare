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
  final changeScreen;
  const Volunteer(this.changeScreen);

  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  Patient patient;
  Patient patient2;
  List<String> qrCodeDataList = [];
  List<SearchedPatient> patients = [];
  List<SearchedPatient> queryResult = [];
  List<SearchedPatient> bodyPatients = [];
  bool loading = false;

  @override
  void initState() {
    _initializePatient();
    super.initState();
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
        body: loading ? LinearProgressIndicator() : _searchScreen());
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
                      ? VolunteerCard(
                          bodyPatients[index].patient, removeElement)
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
                .where((element) => element.patient.name.contains(query))
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
        title: Text(element.patient.name),
        subtitle: Text("Codice Fiscale"),
        trailing: element.body
            ? SizedBox.shrink()
            : ElevatedButton(
                onPressed: () {
                  setState(() {
                    element.body = true;
                    bodyPatients.add(element);
                  });
                },
                child: Text("Aggiungi")),
      ));
    });
    return widgets;
  }

  removeElement(String name) {
    bool exit = false;
    for (int i = 0; i < bodyPatients.length; i++) {
      if (bodyPatients[i].patient.name == name) {
        setState(() {
          patients.forEach((member) {
            if (member.patient.name == name) {
              member.body = false;
            }
          });
          bodyPatients.remove(bodyPatients[i]);
          exit = true;
        });
        if (exit) break;
      }
    }
  }

  _initializePatient() {
    setState(() {
      patient = createPatient();
      patient2 = createPatientWithName("Ciao", "ciaaa");
      patients.add(SearchedPatient(patient, false));
      patients.add(SearchedPatient(patient2, false));
    });
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
    //da rimuovere l'aggiunta in questo punto perché continua ad addare ad ogni click
    setState(() {
      loading = true;
    });
    bodyPatients.forEach((element) {
      qrCodeDataList.add(element.patient.getLifeSavingInformation());
    });
    PDFHandler(qrDataList: qrCodeDataList).openMultipleBadge().whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  generateMultipleCIS() {
    Future.delayed(Duration(seconds: 1), () async {
      setState(() {
        loading = true;
      });
      bodyPatients.forEach((element) {
        qrCodeDataList.add(element.patient.getLifeSavingInformation());
      });
      await PDFHandler(qrDataList: qrCodeDataList, patient: patient)
          .openMultipleCIS()
          .whenComplete(() {
        setState(() {
          loading = false;
        });
      });
    });
    //da rimuovere l'aggiunta in questo punto perché continua ad addare ad ogni click
  }

  generateMultipleBracelet() async {
    //da rimuovere l'aggiunta in questo punto perché continua ad addare ad ogni click
    bodyPatients.forEach((element) {
      qrCodeDataList.add(element.patient.getLifeSavingInformation());
    });
    await PDFHandler(qrDataList: qrCodeDataList).openMultipleBracelet();
  }
}
