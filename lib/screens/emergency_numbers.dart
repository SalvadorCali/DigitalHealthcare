import 'package:flutter/material.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:thesis/widgets/emergency_number_tile.dart';

class EmergencyNumbers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Numeri di Emergenza"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: [
        EmergencyNumberTile(
            Icon(HumanitarianIcons.community_building), "112", "Carabinieri"),
        EmergencyNumberTile(
            Icon(HumanitarianIcons.police_station), "113", "Polizia di Stato"),
        EmergencyNumberTile(
            Icon(HumanitarianIcons.fire), "115", "Vigili del Fuoco"),
        EmergencyNumberTile(Icon(HumanitarianIcons.emergency_telecom), "117",
            "Guardia di Finanza"),
        EmergencyNumberTile(
            Icon(HumanitarianIcons.ambulance), "118", "Emergenza Sanitaria"),
      ],
    );
  }
}
