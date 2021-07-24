// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart';

// class WebviewPage extends StatefulWidget {
//   final String url;

//   const WebviewPage({Key key, @required this.url}) : super(key: key);

//   @override
//   _WebviewPageState createState() => _WebviewPageState();
// }

// class _WebviewPageState extends State<WebviewPage> {
//   InAppWebViewController _webViewController;

//   @override
//   void initState() {
//     super.initState();

//     _requestPermission();
//   }

//   _requestPermission() async {
//     var camera = await Permission.camera.status;
//     var mic = await Permission.microphone.status;
//     if (camera.isDenied || mic.isDenied) {
//       Permission.camera.request();
//       Permission.microphone.request();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: InAppWebView(
//             initialUrlRequest: URLRequest(
//               url: Uri.parse(widget.url),
//             ),
//             initialOptions: InAppWebViewGroupOptions(
//               crossPlatform: InAppWebViewOptions(
//                 useOnDownloadStart: true,
//                 javaScriptEnabled: true,
//                 mediaPlaybackRequiresUserGesture: false,
//               ),
//             ),
//             onWebViewCreated: (InAppWebViewController controller) {
//               _webViewController = controller;
//             },
//             androidOnPermissionRequest: (InAppWebViewController controller,
//                 String origin, List<String> resources) async {
//               return PermissionRequestResponse(
//                   resources: resources,
//                   action: PermissionRequestResponseAction.GRANT);
//             }),
//       ),
//     );
//   }
// }
