// import 'package:codebase_echo/codebase_echo.dart';
// import 'package:pusher_client/pusher_client.dart';

// const REACT_APP_API_DOMAIN = "api.maxstage.id";
// const REACT_APP_WS_KEY = "z6nhzsfjvci1xel1v70at30miaohq04s";
// const REACT_APP_WS_CLUSTER = "mlg11";

// Echo initPusherClient() {
//   PusherOptions options =
//       PusherOptions(host: REACT_APP_API_DOMAIN, cluster: REACT_APP_WS_CLUSTER);

//   PusherClient client =
//       PusherClient(REACT_APP_WS_KEY, options, enableLogging: true);

//   client.onConnectionError((err) => print("Pusher connection error: ${err?.message}"));
//   client.onConnectionStateChange((state) => print("Pusher connection state: ${state?.currentState}"),);


//   return Echo(client: client, broadcaster: EchoBroadcasterType.Pusher);
// }
