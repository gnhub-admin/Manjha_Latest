import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../widget/textstyle.dart';
import '../const.dart';
import '../localconst.dart';

// ignore: must_be_immutable
class CmsPage extends StatefulWidget {
  late String _pageName;

  @override
  CmsPage(pageName) {
    this._pageName = pageName;
  }

  @override
  _CmsPageState createState() => _CmsPageState();
}

class _CmsPageState extends State<CmsPage> {
  @override
  void initState() {
    super.initState();
    _loadContent();
    _loadData();

    print(widget._pageName);
  }

  _loadContent() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      htmlContent = "<h1>" +
          widget._pageName.toUpperCase() +
          "</h1><p>" +
          widget._pageName +
          " text goes here...</p>";
      isLoading = false;
    });
  }

  var isLoading = false;
  String htmlContent = "<p>Loading...</p>";
  String titleContent = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: (/*titleContent != null &&*/ titleContent.isNotEmpty)
            ? AppBar(
                iconTheme: IconThemeData(color: kblack),
                backgroundColor: kwhite,
                title: NormalText(titleContent, kblack, 20),
                centerTitle: false,
                // elevation: 0.0,
              )
            : null,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(color: kheader, strokeWidth: 2),
              )
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: new HtmlWidget(
                  '''$htmlContent''',
                  // padding: EdgeInsets.all(16.0),
                  // onLinkTap: (url) {
                  //   print("Opening $url...");
                  // },
                  // webView: true,
                ),
              )));
  }

  Future<bool> _loadData() async {
    setState(() {
      isLoading = true;
    });
    print('cookie:' + Common.getCookie());
    final response = await http.get(
      Common.getURL("page?page_name=" + widget._pageName),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // "content-type": "application/x-www-form-urlencoded",
        'Cookie': Common.getCookie().toString()
      },
      // body: jsonEncode(<String, String>{
      //   "first_name": firstNameController.text,
      //   "last_name": lastNameController.text,
      //   "emailid": emailController.text,
      // })
    );

    // Common.updateCookie(response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> resBody = jsonDecode(response.body);

      // final parsed = resBody["data"].cast<Map<String, dynamic>>();
      // print(parsed);
      Map<String, dynamic> pageItem = resBody["data"];
      print(pageItem["page_description_lang"]);
      // List<String> fullNameArray = custItem["full_name"].split(" ");
      setState(() {
        htmlContent = "<style>body{background-color: red;}</style>" +
            pageItem["page_description_lang"];
        titleContent = pageItem["page_title_lang"];
      });

      print(pageItem["id"].toString());

      setState(() {
        isLoading = false;
      });
      return true;
    } else {
      throw Exception('Failed to load request');
    }
    // return false;
  }
}
