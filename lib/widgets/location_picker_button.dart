import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPickerButton extends StatefulWidget {
  const LocationPickerButton({Key? key, required this.setLocation, required this.child})
      : super(key: key);

  final Widget child;
  final dynamic setLocation;

  @override
  State<LocationPickerButton> createState() => _LocationPickerButtonState();
}

class _LocationPickerButtonState extends State<LocationPickerButton> {
  double latitude = 0.0;
  double longitude = 0.0;
  double progress = 0.0;
  Location location = Location();

  @override
  Widget build(BuildContext context) {
    bool locationSet = (latitude + longitude != 0.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        progress > 0.0 && location == Location()
            ? LinearProgressIndicator(
                backgroundColor: const Color.fromARGB(255, 199, 180, 251).withOpacity(0.6),
                // value: progress,
              )
            : progress == 1.0
                ? const ElevatedButton(onPressed: null, child: Text('Upload Complete'))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: locationSet
                        ? null
                        : () async {
                            bool serviceEnabled;
                            PermissionStatus permissionGranted;
                            LocationData locationData;

                            serviceEnabled = await location.serviceEnabled();
                            if (!serviceEnabled) {
                              serviceEnabled = await location.requestService();
                              if (!serviceEnabled) {
                                return;
                              }
                            }
                            permissionGranted = await location.hasPermission();

                            if (permissionGranted == PermissionStatus.denied) {
                              permissionGranted = await location.requestPermission();
                              if (permissionGranted != PermissionStatus.granted) {
                                return;
                              }
                            }

                            locationData = await location.getLocation();

                            widget.setLocation(locationData.latitude, locationData.longitude);
                          },
                    child: widget.child,
                  )
      ],
    );
  }
}
