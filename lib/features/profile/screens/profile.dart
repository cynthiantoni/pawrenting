import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pawrentingreborn/common/widgets/appBar/appBar.dart';
import 'package:pawrentingreborn/common/widgets/appBar/appBar2.dart';
import 'package:pawrentingreborn/features/profile/widgets/profileOption.dart';
import 'package:pawrentingreborn/features/profile/widgets/profilePictandUsername.dart';
import 'package:pawrentingreborn/utils/constants/colors.dart';
import 'package:pawrentingreborn/utils/constants/images_strings.dart';
import 'package:pawrentingreborn/utils/constants/texts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // background and App Bar
      appBar: const TAppBar(onMain: true, onPetDetails: false),
      backgroundColor: TColors.primary, 
      body: SingleChildScrollView(
        child: Column(
          children: [
            //profile account section 
            
            Profilepictandusername(
              profilePicture: TImages.userProfilePic, 
              name: "Kelompok 5 AYE", 
              username: "@semangattsay"
            ), 

            //box for the profile option
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 30),
              width: 365, 
              height: 1000,
              decoration: BoxDecoration(
                color: TColors.gray,  
                borderRadius:BorderRadius.circular(15) //ini gtw knp ga muncul di screen 
              ),

              child: Column(
                children: [
                  //profile section 1
                  Padding(
                    padding: EdgeInsets.only(right: 250, top: 15, bottom: 10),
                    child: Text(
                      "Your account", 
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Albert Sans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // section 1.1
                  ProfileOption(
                    text: "Personal Data" , 
                    imagePath: TImages.personalDataIcon,
                  ),
                  //section 1.2
                  ProfileOption(
                    text: "Location", 
                    imagePath: TImages.locationIcon,
                  ),
                  //section 1.3
                  ProfileOption(
                    text: "My Voucher", 
                    imagePath: TImages.voucherIcon,
                  ),

                  // Profile section 2 
                  Padding(
                    padding: EdgeInsets.only(right: 190, top: 15, bottom: 10),
                    child: Text(
                      "More info and support", 
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Albert Sans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // section 2.1
                  ProfileOption(
                    text: "FAQ", 
                    imagePath: TImages.faqIcon,
                  ),
                  // section 2.2
                  ProfileOption(
                    text: "Terms and Conditions",  
                    imagePath: TImages.termsIcon,
                  ),
                  // section 2.3
                  ProfileOption(
                    text: "Privacy Policy", 
                    imagePath: TImages.privacyIcon,
                  ),

                  //Section 3 
                  Padding(
                    padding: EdgeInsets.only(right: 260, top: 15, bottom: 10),
                    child: Text(
                      "Contact us", 
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Albert Sans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //section 3.1 
                  ProfileOption(
                    text: "+6281234356789", 
                    imagePath: TImages.phoneIcon,
                  ),
                  // section 3.2
                  ProfileOption(
                    text: "pawrenting@gmail.com",  
                    imagePath: TImages.emailIcon,
                  ),
                  //section 3.3
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Image.asset(
                          TImages.logoutIcon,
                          width: 19,
                          height: 19,
                          matchTextDirection: true,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Alata',
                              fontWeight: FontWeight.bold,
                              color: TColors.redLogout, // Assuming TColors.grayFont is a gray color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: TColors.redLogout,
                    thickness: 1.5,
                    indent: 40,
                    endIndent: 20,
                  ),
              
                ],

              ),
            ),

          ] 
        ), 
      ),    
    );
  }
}
