    //  bottomNavigationBar: Container(
    //     decoration: BoxDecoration(
    //         color: Colors.white,
    //         // Background color of bottom navigation bar

    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.grey.withOpacity(0.3), // Shadow color
    //             spreadRadius: 5, // Extent of shadow spreading
    //             blurRadius: 5, // Blur intensity
    //             offset:
    //                 Offset(0, 0), // Horizontal and vertical shadow positioning
    //           ),
    //         ],
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(15), topRight: Radius.circular(15))
    //         // borderRadius: BorderRadius.vertical(
    //         //     top: Radius.circular(20)), // Rounded corners
    //         ),
    //     child: Obx(
    //       () => BottomNavigationBar(
    //         type: BottomNavigationBarType.fixed,

    //         elevation: 0, // Makes all items visible
    //         backgroundColor:
    //             Colors.white10, // Transparent to show container's color
    //         selectedItemColor: Colors.black, // Color of the selected item
    //         unselectedItemColor: Colors.black, // Color of unselected items
    //         showSelectedLabels: true, // Show labels on selection
    //         showUnselectedLabels: false, // Hide labels for unselected items
    //         // currentIndex: widget.currentIndex!,
    //         currentIndex: userTabController.currentTabIndex.value,

    //         selectedLabelStyle: poppinsFont(8, Colors.black, FontWeight.w500),
    //         onTap: (index) {
    //           // setState(() {
    //           //   widget.currentIndex = index;
    //           // });
    //           userTabController.currentTabIndex.value = index;
    //         },
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: userTabController.currentTabIndex.value == 0
    //                 ? Stack(
    //                     alignment: Alignment.bottomCenter,
    //                     clipBehavior: Clip.none,
    //                     children: [
    //                       Image.asset(
    //                         'assets/images/focus.png', // Your focus image
    //                         height: 40, width: 50,
    //                         fit: BoxFit.fill, // Adjust the size as needed
    //                       ),
    //                       Column(
    //                         children: [
    //                           Image.asset(
    //                             'assets/images/home-3.png', // Original tab icon
    //                             height: 20,
    //                           ),
    //                           Text(
    //                             'Home',
    //                             style: poppinsFont(6, Colors.black,
    //                                 FontWeight.w500), // Your label style
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   )
    //                 : Image.asset(
    //                     'assets/images/home-2.png', // Original unselected icon
    //                     height: 20,
    //                   ),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: userTabController.currentTabIndex.value == 1
    //                 ? Stack(
    //                     alignment: Alignment.bottomCenter,
    //                     clipBehavior: Clip.none,
    //                     children: [
    //                       Image.asset(
    //                         'assets/images/focus.png', // Your focus image
    //                         height: 40, width: 50,
    //                         fit: BoxFit.fill, // Adjust the size as needed
    //                       ),
    //                       Column(
    //                         children: [
    //                           Image.asset(
    //                             'assets/images/explore_icon2.png', // Original tab icon
    //                             height: 20,
    //                           ),
    //                           Text(
    //                             'Explore',
    //                             style: poppinsFont(6, Colors.black,
    //                                 FontWeight.w500), // Your label style
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   )
    //                 : Image.asset(
    //                     'assets/images/explore_icon.png', // Original unselected icon
    //                     height: 20,
    //                   ),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: userTabController.currentTabIndex.value == 2
    //                 ? Stack(
    //                     alignment: Alignment.bottomCenter,
    //                     clipBehavior: Clip.none,
    //                     children: [
    //                       Image.asset(
    //                         'assets/images/focus.png', // Your focus image
    //                         height: 40, width: 60,
    //                         fit: BoxFit.fill, // Adjust the size as needed
    //                       ),
    //                       Column(
    //                         children: [
    //                           Image.asset(
    //                             'assets/images//element-3.png', // Original tab icon
    //                             height: 20,
    //                           ),
    //                           Text(
    //                             'Categories',
    //                             style: poppinsFont(6, Colors.black,
    //                                 FontWeight.w500), // Your label style
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   )
    //                 : Image.asset(
    //                     'assets/images/element3.png', // Original unselected icon
    //                     height: 20,
    //                   ),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: userTabController.currentTabIndex.value == 3
    //                 ? Stack(
    //                     alignment: Alignment.bottomCenter,
    //                     clipBehavior: Clip.none,
    //                     children: [
    //                       Image.asset(
    //                         'assets/images/focus.png', // Your focus image
    //                         height: 40, width: 60,
    //                         fit: BoxFit.fill, // Adjust the size as needed
    //                       ),
    //                       Column(
    //                         children: [
    //                           Image.asset(
    //                             'assets/images/fill_heart.png',
    //                             height: 20,
    //                             color: AppColors.blue,
    //                           ),
    //                           Text(
    //                             'Favourites',
    //                             style: poppinsFont(6, Colors.black,
    //                                 FontWeight.w500), // Your label style
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   )
    //                 : Image.asset(
    //                     'assets/images/heart.png', // Original unselected icon
    //                     height: 20,
    //                   ),
    //             label: '',
    //           ),
    //           BottomNavigationBarItem(
    //             icon: userTabController.currentTabIndex.value == 4
    //                 ? Stack(
    //                     alignment: Alignment.bottomCenter,
    //                     clipBehavior: Clip.none,
    //                     children: [
    //                       Image.asset(
    //                         'assets/images/focus.png', // Your focus image
    //                         height: 40, width: 60,
    //                         fit: BoxFit.fill, // Adjust the size as needed
    //                       ),
    //                       Column(
    //                         children: [
    //                           Image.asset(
    //                             'assets/images/setting (1).png',
    //                             height: 20,
    //                           ),
    //                           Text(
    //                             'Setting',
    //                             style: poppinsFont(6, Colors.black,
    //                                 FontWeight.w500), // Your label style
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   )
    //                 : Image.asset(
    //                     'assets/images/element5.png', // Original unselected icon
    //                     height: 20,
    //                   ),
    //             label: '',
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),






    