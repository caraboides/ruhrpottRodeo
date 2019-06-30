import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'menu.dart';
import 'package:url_launcher/url_launcher.dart';


const String html = '''
<div itemprop="articleBody">
<p><span style="font-size: 12pt;">Der Campingplatz befindet sich direkt zwischen Parkplatz und Festivalgelände. Es ist nicht möglich neben dem Zelt zu parken. Für Wohnmobile gibt es eine extra Ecke.</span></p>
<p><span style="font-size: 12pt;"><strong>Adresse für’s Navi:</strong></span></p>
<p><span style="font-size: 12pt;">Langer Weg</span><br><span style="font-size: 12pt;">Ecke Dinslakener Str.</span><br><span style="font-size: 12pt;">46569 Hünxe</span><br><br></p>
<p><span style="font-size: 12pt;"><strong>Shuttle Busse vom Bahnhof Dinslaken zum Festival und zurück!</strong></span></p>
<p><span style="font-size: 12pt;">Auch beim Rodeo 2019 werden wie in den letzten Jahren wieder Shuttle Busse zum Festival fahren.</span></p>
<p><span style="font-size: 12pt;"><strong>Achtung: Der Abfahrtsbahnhof hat sich geändert!<br>Die Busse fahren nicht mehr vom Bahnhof Feldhausen aus zum Festival, sondern vom <span style="text-decoration: underline;">Bahnhof Dinslaken</span>.</strong></span></p>
<p>&nbsp;</p>
<p><span style="font-size: 12pt;"><em>Donnerstag, 4. Juli &nbsp;17:00 - 23:00Uhr / alle 30 min</em></span></p>
<p><span style="font-size: 12pt;"><em>Freitag, &nbsp;5 Juli &nbsp; 10:00 - 02:00 Uhr &nbsp;/ alle 30 min</em></span></p>
<p><span style="font-size: 12pt;"><em>Samstag, &nbsp;6 Juli &nbsp;11:00 - 02:00 Uhr &nbsp;/ alle 30 min</em></span></p>
<p><span style="font-size: 12pt;"><em>Sonntag, 7. Juli &nbsp;11:00 - 02:00 Uhr / alle 30 min</em></span></p>
<p><span style="font-size: 12pt; font-family: tahoma, arial, helvetica, sans-serif;"><em>Montag, 8.Juli &nbsp;09:00 - 14:00 Uhr / alle 30 min</em></span></p>
<p>&nbsp;</p>
<pre><span style="font-family: tahoma, arial, helvetica, sans-serif;"><span style="font-size: 12pt;">Transferzeit: ca 15 Minuten</span></span></pre>
<p><span style="font-size: 12pt; font-family: tahoma, arial, helvetica, sans-serif;">Kosten pro Fahrt: 3 Euro</span></p>
<p><span style="font-size: 12pt; font-family: tahoma, arial, helvetica, sans-serif;">Unter downloads kannst du eine Anfahrtsskizze herunterladen</span><br><br><span style="font-size: 12pt; font-family: tahoma, arial, helvetica, sans-serif;">Homepage Bahnhof Feldhausen:<a href="http://www.mein-bahnhof.de/feldhausen.html"> http://www.mein-bahnhof.de/feldhausen.html</a></span></p>	</div>
''';



class Drive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String contentBase64 = base64Encode(const Utf8Encoder().convert(html));
    String url = "data:text/html;base64,$contentBase64";
    final navigator = Navigator.of(context);
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: Text('Anfahrt'),
      ),
      body: Center(
        child:  WebView(initialUrl: url,javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            launch(request.url);
            return NavigationDecision.prevent;
          },
        )
      ),
    );
  }
}
