import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rfb/flutter_rfb.dart';

class InstanceRfbScreen extends StatefulWidget {
  const InstanceRfbScreen({super.key});

  @override
  State<InstanceRfbScreen> createState() => _InstanceRfbScreenState();
}

class _InstanceRfbScreenState extends State<InstanceRfbScreen> {
  final String url =
      "wss://dc1-wss.maxstage.id?t=655F0289%3A%3AeCz204eD8EKPKxDWavRp7ODyI8k7wQEnhm7RjNGVi7tCWzuWR%2Fq%2BLDqQRIhd%2BfnDsw6ivdjcbbBR7ES2dVOx7OVBKTRFFJJQLbidXfinvjza%2FoCaiuT3w6eQcyCcJZtoZRBZNOLzcW5A%2Btss3OLxFdk9WtWKoRhOIR4J0W2Zah%2FJ0CrsS4YMFELjqTiHkFXbq%2BA%2BcRwTCsCu7ymFfXN7ZZ5lrD2Tt1W8oVRYWsyZapHCTxkq6LVnWzcIs0o60RsqI4eQASeBzDpNnDziKmX3Fm1PhAd97%2BJBuMEke3sLQdhGMqqs5ffnPDy8cZlEV3dTwBgCpxDELwO2mZTy2jr%2Fjw%3D%3D&ae=dc1-scalable-hv1&n=dc1-epyc-hv1&i=1014&p=5900";
  final String password = "Y<6\"DK9E";

  bool _connected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Detail",
                  style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                          color: Color(0xff353333),
                          fontSize: 25,
                          fontWeight: FontWeight.w600))),
            ],
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
                height: 24, fit: BoxFit.scaleDown),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _connected = !_connected;
                  });
                },
                child: Text(_connected ? 'Disconnect' : 'Connect'),
              ),
              ..._connected
                  ? <Widget>[
                      Expanded(
                        child: Center(
                          child: InteractiveViewer(
                            constrained: true,
                            maxScale: 10,
                            child: Builder(
                              builder: (final BuildContext context) =>
                                  RemoteFrameBufferWidget(
                                hostName: Uri.decodeFull(url),
                                onError: (final Object error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: $error'),
                                    ),
                                  );
                                  setState(() {
                                    _connected = false;
                                  });
                                },
                                password: password,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  : <Widget>[],
            ],
          ),
        ));
  }
}
