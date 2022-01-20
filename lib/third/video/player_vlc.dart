import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:svran_flutter_study/public_code.dart';

class VlcDemo extends StatefulWidget {
  const VlcDemo({Key? key}) : super(key: key);

  @override
  State<VlcDemo> createState() => _VlcDemoState();
}

class _VlcDemoState extends State<VlcDemo> {
  final userName = "test";
  final realm = "0";
  final password = "maiyuan!2#";
  final uri = "rtsp://192.168.10.146:554/ch1/main/av_stream";
  final urlPath = "/ch1/main/av_stream";
  final nonce = "svran";
  Player player = Player(id: 0);

  final localUrl = "rtsp://127.0.0.1:8554/test";
  final remoteUrl = "rtsp://test:0:maiyuan!2%23@192.168.10.146:554/ch1/main/av_stream";

  @override
  Widget build(BuildContext context) {
    // H(A1) = MD5(user:realm:pass)
    // H(A2) = MD5(method:digestURI)
    // response = MD5(H(A1):nonce:H(A2)
    // Digest username="test", realm="0", nonce="e539951941e259b7e69f7642cb5ea498", uri="/ch1/main/av_stream", response="e68bd443e12e95e91f06225f3dfefe93"
    final h1 = _md5("$userName:$realm:$password");
    final h2 = _md5("rtsp:$uri");
    final response = _md5("$h1:$nonce:$h2");

    final b64 = utf8.fuse(base64);
    final b64str = b64.encode("$userName:0:$password");
    player.open(
      Media.directShow(rawUrl: "rtsp://192.168.10.146:554$urlPath", args: {"Authorization": getAuthorization("tcp")}),
    );
    // player.open(Media.directShow(rawUrl: "rtsp://$userName:$password@192.168.10.146:554$urlPath"));
    // player.open(Media.directShow(rawUrl: localUrl));
    // player.open(Media.directShow(rawUrl: remoteUrl));
    // player.open(Media.directShow(rawUrl: uri));
    // logger.d("Svran: Flutter -> $b64str");
    return Scaffold(
      appBar: AppBar(
        title: const Text("测试"),
      ),
      body: Video(
        player: player,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  String _md5(String str) {
    return md5.convert(utf8.encode(str)).toString();
  }

  String getAuthorization(String method) {
    String hash1 = _md5(userName + ":" + realm + ":" + password);
    String hash2 = _md5(method + ":" + uri);
    String hash3 = _md5(hash1 + ":" + nonce + ":" + hash2);
    String mAuthorization =
        "Digest username=\"$userName\",realm=\"$realm\",nonce=\"$nonce\",uri=\"$uri\",response=\"$hash3\"";
    logger.d("Svran: Flutter -> digest: $mAuthorization");
    return mAuthorization;
  }
}
