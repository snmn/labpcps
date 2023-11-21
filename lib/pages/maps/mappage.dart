// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapSample extends StatefulWidget {
//   const MapSample({super.key});
//
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   final Completer<GoogleMapController> _controller =
//   Completer<GoogleMapController>();
//
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(27.686382, 85.315399),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //define raw file here
//     _loadMapStyles();
//     loadmapdelay();
//
//   }
//   bool showmap=false;
//   loadmapdelay(){
//     //delay
//     Future.delayed(const Duration(seconds: 1)).whenComplete((){
//     setState(() {
//       showmap =true;
//     });
//     });
//   }
//   var maptheme;
//   Future _loadMapStyles() async {
//     maptheme  = await rootBundle.loadString('asset/raw/maptheme.json');
//   }
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           showmap?GoogleMap(
//             initialCameraPosition: _kGooglePlex,
//             markers: {
//               const Marker(
//                 markerId: const MarkerId("kupondole"),
//                 position: LatLng(27.686382, 85.315399),
//                 infoWindow: InfoWindow(
//                   title: "Kupondole",
//                   snippet: "PCPS TEST",
//                 ), // InfoWindow
//               ),
//
//             },
//
//             onMapCreated: (GoogleMapController controller) {
//               // theme change code here
//               controller.setMapStyle(maptheme);
//               //
//               _controller.complete(controller);
//
//               // code here //marker //ontap //
//             },
//           ):Container(
//             child: Center(child: CircularProgressIndicator()),
//           ),
//
//           Positioned(
//             top: 15,
//             left: 0,
//             child: Container(
//               padding: EdgeInsets.all(15),
//               height: 60,
//               width: size.width,
//              decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.circular(20)
//              ),
//             ),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: gotocollege,
//         label: const Text('To the college!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }
//
//   Future<void> gotocollege() async {
//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.686382, 85.315399),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(27.68, 85.315),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  bool showmap = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markerinit();
    _loadMapStyles();
    showmapfunc();


  }

  _markertapped(){

  }
  List<Marker> markerlist = [];
  markerinit(){
    markerlist = [
      const Marker(
      markerId: MarkerId('Kupondole'),
      position: LatLng(27.686382, 85.315399),
      // infoWindow: InfoWindow(
      //   title: "Kupondole",
      //   snippet: "PCPS Kupondole",
      // ), // In
    ),
      const Marker(
        markerId: MarkerId('Thapathali'),
        position: LatLng(27.686355, 85.315355),
        infoWindow: InfoWindow(
          title: "Thapathali",
          snippet: "PCPS Thapathali",
        ), // In
      )
    ];
  }



  var mapthemedata;
  Future _loadMapStyles() async {
    mapthemedata  = await rootBundle.loadString('asset/raw/maptheme.json');
  }
  showmapfunc(){
    Future.delayed(Duration(seconds: 1)).whenComplete((){
      setState(() {
        showmap =true;
      });
    });
  }
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          showmap?GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(markerlist),
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(mapthemedata);
              _controller.complete(controller);
            },

            onTap: (event){
              //on map click
            },
            onCameraMove: (event){
              // no api call
            },
            onCameraIdle: (){
              // api calls
            },
          ):Container(
            child: Center(child: CircularProgressIndicator()),
          ),

          //search
          Positioned(
            top: 20,
            left: 0,
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              height: 60,
              width: size.width,
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
              child: TextField(
                //search work
                controller: _searchController,
                onEditingComplete: (){
                  // on complete task
                },
                onSubmitted: (val){
                  //on submitted task
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}