import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:petbuddy/login.dart';
import 'AboutUs.dart';
import 'Addpet.dart';
import 'MatingPartner.dart';

import 'Profile.dart';
import 'Request.dart';
import 'Rescue.dart';
import 'Salon.dart';
import 'adopter.dart';
import 'contact_us.dart';
import 'dr_concert.dart';
import 'history.dart';
import 'my_drawer.dart';
import 'dashboard.dart';
import 'Trainer.dart';
import 'MyPet.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;
  String selectedCity = 'Loading...'; // City name variable

  Location location = Location();


  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    // Location permission check and getting user's location code
    // Similar to the previous code snippet provided
  }



  @override
  Widget build(BuildContext context) {
    var container;

    if (currentPage == DrawerSections.Profile) {
      container = ProfilePage();
    }

    else if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    }

    else if (currentPage == DrawerSections.MyPet) {
      container = MyPetListView();
    }
    else if (currentPage == DrawerSections.Addpet) {
      container = addPet();
    }
    else if (currentPage == DrawerSections.adopter) {
      container = adopter();
    }

    else if (currentPage == DrawerSections.dr_concert)
    {
      container = dr_concertPage();
    }
    else if (currentPage == DrawerSections.history)
    {
      container = MyHistoryPage();
    }
    else if (currentPage == DrawerSections.trainer)
    {
      container = trainer_Page();
    } else if (currentPage == DrawerSections.Request)
    {
      container = RequestPage();
    }
    else if (currentPage == DrawerSections.contact_us)
    {
      container = ContactUsPage();
    }
    else if (currentPage ==  DrawerSections.MatingPartner)
    {
      container = MatingPartnerPage();
    }


    else if (currentPage == DrawerSections.AboutUs) {
      container = AboutUsPage();
    }

    else if (currentPage == DrawerSections.MyPhone)
    {
      container = MyPhone();
    }

    else if (currentPage == DrawerSections.salon)
    {
      container = salon_Page();
    }
    else if (currentPage == DrawerSections.Rescue)
    {
      container = Rescue();
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("PetBuddy 🐾"),


      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Profile", Icons.person,
              currentPage == DrawerSections.Profile ? true : false),
          menuItem(2, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(3, "MyPet", Icons.pets_rounded,
              currentPage == DrawerSections.MyPet ? true : false),

          menuItem(4, "Addpet", Icons.add_box,
              currentPage == DrawerSections.Addpet ? true : false),
          menuItem(5, "Adopter", Icons.add_box_outlined,
              currentPage == DrawerSections.adopter ? true : false),
          menuItem(6, "Doctor", Icons.people_alt_outlined,
              currentPage == DrawerSections.dr_concert ? true : false),
          menuItem(7, "History", Icons.history,
              currentPage == DrawerSections.history ? true : false),
          menuItem(8, "Trainer", Icons.school_rounded,
              currentPage == DrawerSections.trainer ? true : false),
          menuItem(9, "Salon", Icons.cut_outlined,
              currentPage == DrawerSections.salon? true : false),
          menuItem(10, "Request", Icons.request_page,
              currentPage == DrawerSections.salon ? true : false),

          menuItem(11, "Find Mating Partner", Icons.find_in_page_outlined,
              currentPage == DrawerSections.MatingPartnerPage ? true : false),

           menuItem(12, "Rescue", Icons.live_help_rounded,
              currentPage == DrawerSections.Rescue ? true : false),
          menuItem(13, "Contact Us", Icons.contact_support,
              currentPage == DrawerSections.contact_us ? true : false),
          menuItem(14, "About Us", Icons.info_outlined,
              currentPage == DrawerSections.AboutUs ? true : false),

          Divider(),

          menuItem(15, "Logout", Icons.logout_rounded,
              currentPage == DrawerSections.login ? true : false),


        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,


      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {

            if (id == 1) {
              currentPage = DrawerSections.Profile;
            }
             else if (id == 2) {
              currentPage = DrawerSections.dashboard;
            }

            else if (id == 3) {
              currentPage = DrawerSections.MyPet;
            }
            else if (id == 4 ){
              currentPage = DrawerSections.Addpet;
            }else if (id == 5) {
              currentPage = DrawerSections.adopter;
            }

            else if (id == 6) {
              currentPage = DrawerSections.dr_concert;
            } else if (id == 7) {
              currentPage = DrawerSections.history;
            } else if (id == 8) {
              currentPage = DrawerSections.trainer;
            }
            else if (id == 9 ){
              currentPage = DrawerSections.salon;
            }
             else if (id == 10) {
              currentPage = DrawerSections.Request;
            }
              else if (id ==11)
                {
                  currentPage ==DrawerSections.MatingPartner; // chnge salon to mp
                }

            else if (id == 12) {
              currentPage = DrawerSections.Rescue;
            }
             else if (id == 13) {
              currentPage = DrawerSections.contact_us;
            } else if (id == 14) {
              currentPage = DrawerSections.AboutUs;

            } else if (id == 15) {
              currentPage = DrawerSections.MyPhone;
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
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,

                  ),
                ),
              ),
            ],
          ),
        ),

      ),
      borderRadius: BorderRadius.circular(20.0),
    );
  }
}



enum DrawerSections {
  Addpet,
  dr_concert,
  history,
  how_to_take_care,
  Request,
  dashboard,
  tc,
  MyPhone,
  salon,
  contact_us,
  MyRegister,
  AboutUs,
  adopter,
  Profile,
  trainer,
  MyPet, Rescue, MatingPartner, login, MatingPartnerPage

}

