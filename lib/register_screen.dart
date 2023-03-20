// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'about_screen.dart';
import 'blog_screen.dart';
import 'contact_screen.dart';
import 'experts.dart';
import 'faq_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'my_drawer_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Color mainColor = Color(0xFF734D9F);
  var currentPage = DrawerSection.register;
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    if (Platform.isIOS) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  int _selectedIndex = 2;
  List<String> urlList = <String>[
    'https://crowandferret.com/',
    'https://crowandferret.com/about-us/',
    'https://crowandferret.com/contact-us/',
  ];

  void _onTabTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        _selectedIndex = 0;
      } else if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));

        _selectedIndex = 1;
      } else if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterScreen()));
        _selectedIndex = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crow & Ferret'),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Stack(
        children: [
          Builder(builder: (BuildContext context) {
            return WebView(
              initialUrl: 'https://crowandferret.com/user/register/',
              javascriptMode: JavascriptMode.unrestricted,

              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                //print("WebView is loading (progress : $progress%)");
              },
              // javascriptChannels: <JavascriptChannel>{
              //   _toasterJavascriptChannel(context),
              // },

              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                setState(() {
                  _isLoading = true;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
              },
              backgroundColor: Colors.white,
              gestureNavigationEnabled: true,
              geolocationEnabled: true, //support geolocation or not
            );
          }),
          _isLoading ? Center(child: CircularProgressIndicator()) : Stack(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          label: 'Login',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.app_registration),
          label: 'Register',
        ),
      ], currentIndex: _selectedIndex, onTap: _onTabTapped),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyDrawerHeader(),
                myDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSection.home ? true : false),
          menuItem(2, "About Us", Icons.people,
              currentPage == DrawerSection.aboutUs ? true : false),
          menuItem(3, "Experts", Icons.navigation_rounded,
              currentPage == DrawerSection.experts ? true : false),
          menuItem(4, "FAQ", Icons.question_answer,
              currentPage == DrawerSection.faq ? true : false),
          menuItem(5, "Blog", Icons.personal_video_rounded,
              currentPage == DrawerSection.blog ? true : false),
          menuItem(6, "Contact Us", Icons.contact_mail,
              currentPage == DrawerSection.contactUs ? true : false),
          menuItem(7, "Login", Icons.login,
              currentPage == DrawerSection.login ? true : false),
          menuItem(8, "Register", Icons.app_registration_outlined,
              currentPage == DrawerSection.register ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          //Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSection.home;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            } else if (id == 2) {
              currentPage = DrawerSection.aboutUs;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()));
            } else if (id == 3) {
              currentPage = DrawerSection.experts;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExpertsScreen()));
            } else if (id == 4) {
              currentPage = DrawerSection.faq;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FaqScreen()));
            } else if (id == 5) {
              currentPage = DrawerSection.blog;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BlogScreen()));
            } else if (id == 6) {
              currentPage = DrawerSection.contactUs;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactUsScreen()));
            } else if (id == 7) {
              currentPage = DrawerSection.login;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            } else if (id == 8) {
              currentPage = DrawerSection.register;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: mainColor,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection {
  home,
  aboutUs,
  experts,
  faq,
  blog,
  contactUs,
  login,
  register,
}
