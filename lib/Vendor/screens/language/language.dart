// CREATE TABLE translations (
//     id SERIAL PRIMARY KEY,
//     key VARCHAR(255) UNIQUE NOT NULL,
//     english TEXT NOT NULL
// );

// INSERT INTO translations  VALUES

import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List ll = [
    ('Hello', 'Hello'),
    ('Search Service', 'Search Services'),
    ('Increase Business Profile Score', 'Increase Business Profile Score'),
    ('Reach out to more Customers', 'Reach out to more Customers'),
    ('Increase Score', 'Increase Score'),
    ('Professional Dashboard', 'Professional Dashboard'),
    ('11.5K views in last 30 days', '11.5K views in last 30 days'),
    ('Grow Your ', 'Grow Your '),
    ('Business', 'Business'),
    ('Sponsor Now', 'Sponsor Now'),
    ('Quick Links', 'Quick Links'),
    ('Edit Profile', 'Edit Profile'),
    ('Add Photos', 'Add Photos'),
    ('Add Contact', 'Add Contact'),
    ('Business Timings', 'Business Timings'),
    ('Reviews', 'Reviews'),
    ('Add Website', 'Add Website'),
    ('Add Video', 'Add Video'),
    ('Add Social Links', 'Add Social Links'),
    ('My Business', 'My Business'),
    ('Business Tools', 'Business Tools'),
    ('Manage Offers, Reviews and more', 'Manage Offers, Reviews and more'),
    ('Services', 'Services'),
    ('Add Services, List, and Edit it', 'Add Services, List, and Edit it'),
    ('Payment History', 'Payment History'),
    (
      'See all the sponsored payment history',
      'See all the sponsored payment history'
    ),
    ('Support', 'Support'),
    ('Connect with Us', 'Connect with Us'),
    ('Business', 'Business'),
    ('Business Name', 'Business Name'),
    ('Business Timings', 'Business Timings'),
    ('Open Now', 'Open Now'),
    ('Year of Establishment', 'Year of Establishment'),
    ('Business categories', 'Business categories'),
    ('Number of Employees', 'Number of Employees'),
    ('Employees', 'Employees'),
    ('Business Website', 'Business Website'),
    ('Follow on Social Media', 'Follow on Social Media'),
    ('Business Images', 'Business Images'),
    ('Contact Details', 'Contact Details'),
    ('Business Address', 'Business Address'),
    (
      ' Make your business look more trustworthy by uploding images of your business premises',
      ' Make your business look more trustworthy by uploding images of your business premises'
    ),
    ('Add Business Images', 'Add Business Images'),
    ('Service Image', 'Service Image'),
    (
      "Note: You can upload images with ‘jpg’, ‘png’, ‘jpeg’ extensions & you can select multiple images",
      "Note: You can upload images with ‘jpg’, ‘png’, ‘jpeg’ extensions & you can select multiple images"
    ),
    ('Please add you store images', 'Please add you store images'),
    ('Save', 'Save'),
    ('Contact Detail', 'Contact Detail'),
    (
      ' Update your contact details to stay in touch your customers in real time',
      ' Update your contact details to stay in touch your customers in real time'
    ),
    ('Mobile Number', 'Mobile Number'),
    ('Add Mobile Number', 'Add Mobile Number'),
    ('Email', 'Email'),
    (
      ' ELet your customers know when to reach you. you can also configure dual timing slots in a single day.',
      ' ELet your customers know when to reach you. you can also configure dual timing slots in a single day.'
    ),
    ('Business Time', 'Business Time'),
    ('Business Opening Hours', 'Business Opening Hours'),
    (
      'Select the multiple days you want to provide the service to the users',
      'Select the multiple days you want to provide the service to the users'
    ),
    ('Start Time', 'Start Time'),
    ('End Time', 'End Time'),
    ('Select Days of the Week', 'Select Days of the Week'),
    (
      'Select the multiple days you want to provide the service to the users',
      'Select the multiple days you want to provide the service to the users'
    ),
    ('Closed', 'Closed'),
    (
      'Please select your business week timings',
      'Please select your business week timings'
    ),
    (
      'Please add your business start time',
      'Please add your business start time'
    ),
    ('Please add your business end time', 'Please add your business end time'),
    ('Business Reviews', 'Business Reviews'),
    ('User Review', 'User Review'),
    ('Review', 'Review'),
    ('User Review Not Found', 'User Review Not Found'),
    (
      'Please provide the URL of your business website so customers can reach you.',
      'Please provide the URL of your business website so customers can reach you.'
    ),
    ('Add Business Website', 'Add Business Website'),
    ('Website', 'Website'),
    ('Please add you business name', 'Please add you business name'),
    ('Business Videos', 'Business Videos'),
    (
      ' Make your business look more trustworthy by uploding videos of your business premises',
      ' Make your business look more trustworthy by uploding videos of your business premises'
    ),
    ('Add Business Video', 'Add Business Video'),
    ('Service Video', 'Service Video'),
    (
      'Note: You can upload only one video',
      'Note: You can upload only one video'
    ),
    ('Please add business video', 'Please add business video'),
    ('Business Videos', 'Business Videos'),
    (
      ' Make your business look more trustworthy by uploding videos of your business premises',
      ' Make your business look more trustworthy by uploding videos of your business premises'
    ),
    ('Add Business Video', 'Add Business Video'),
    ('Service Video', 'Service Video'),
    (
      'Note: You can upload only one video',
      'Note: You can upload only one video'
    ),
    ('Please add business video', 'Please add business video'),
    ('Follow on Social Media', 'Follow on Social Media'),
    (
      ' Please provide the URL of your business website so customers can reach you.',
      ' Please provide the URL of your business website so customers can reach you.'
    ),
    ('Follow Us on', 'Follow Us on'),
    ('Please add social meadia link', 'Please add social meadia link'),
    ('Add What’s app link', 'Add What’s app link'),
    ('Add Facebook profile link', 'Add Facebook profile link'),
    ('Add Instagram profile link', 'Add Instagram profile link'),
    ('Add Twitter profile link', 'Add Twitter profile link'),
    ('All Service', 'All Service'),
    ('No Services is Added', 'No Services is Added'),
    ('Add Service', 'Add Service'),
    ('Edit', 'Edit'),
    ('Service deleted successfully', 'Service deleted successfully'),
    ('Delete', 'Delete'),
    ('Update Service', 'Update Service'),
    ('Add Service', 'Add Service'),
    ('Add Business Images', 'Add Business Images'),
    ('Service Image', 'Service Image'),
    (
      'Note: You can upload images with ‘jpg’, ‘png’, ‘jpeg’ extensions & you can select multiple images',
      'Note: You can upload images with ‘jpg’, ‘png’, ‘jpeg’ extensions & you can select multiple images'
    ),
    ('Service Name', 'Service Name'),
    ('Service Description', 'Service Description'),
    ('Price', 'Price'),
    ('Attach Files', 'Attach Files'),
    ('Add Files', 'Add Files'),
    ('Payment History', 'Payment History'),
    ('Price Details', 'Price Details'),
    ('Selected Ad Days', 'Selected Ad Days'),
    ('Platform Charges', 'Platform Charges'),
    ('Total Amount', 'Total Amount'),
    ('Support', 'Support'),
    ('FAQ’s', 'FAQ’s'),
    ('Customer Support', 'Customer Support'),
    ('FAQ', 'FAQ'),
    ('Search Services', 'Search Services'),
    ("No Faq's Are Found", "No Faq's Are Found"),
    ('Name', 'Name'),
    ('Email', 'Email'),
    ('Phone', 'Phone'),
    ('Message', 'Message'),
    ('Write Message', 'Write Message'),
    ('GDPR Agreement', 'GDPR Agreement'),
    (
      'Please accept the terms before proceeding.',
      'Please accept the terms before proceeding.'
    ),
    ('Please enter your name', 'Please enter your name'),
    ('Please enter your email', 'Please enter your email'),
    ('Please enter your mobile number', 'Please enter your mobile number'),
    ('Please enter your message', 'Please enter your message'),
    ('Send Message', 'Send Message'),
    (
      'I Agree that this app will store my submitted information so that they can respond to my request.',
      'I Agree that this app will store my submitted information so that they can respond to my request.'
    ),
    ('Customer Support', 'Customer Support'),
    ('Message', 'Message'),
    ('No Messages to show', 'No Messages to show'),
    ('Listing Search', 'Listing Search'),
    ('Block Account', 'Block Account'),
    ('Unblock Account', 'Unblock Account'),
    ('Report', 'Report'),
    ('Block', 'Block'),
    ('UnBlock', 'UnBlock'),
    ('Start your conversation', 'Start your conversation'),
    ('No Messages to show', 'No Messages to show'),
    (
      ' This user is currently blocked and unavailable.',
      ' This user is currently blocked and unavailable.'
    ),
    ('Type Message', 'Type Message'),
    ('Message copied', 'Message copied'),
    ('Gallery', 'Gallery'),
    ('Document', 'Document'),
    (
      'Are you sure you want to \nBlock Account?',
      'Are you sure you want to \nBlock Account?'
    ),
    (
      'Are you sure you want to \nUnblock Account?',
      'Are you sure you want to \nUnblock Account?'
    ),
    ('Cancel', 'Cancel'),
    ('why are you reporting this Post?', 'why are you reporting this Post?'),
    ('Report List Empty', 'Report List Empty'),
    ('Notification', 'Notification'),
    ('Settings', 'Settings'),
    ('Profile', 'Profile'),
    ('Business Review', 'Business Review'),
    ('Nlytical Feedback', 'Nlytical Feedback'),
    ('App Feedback', 'App Feedback'),
    ('Privacy & Policy', 'Privacy & Policy'),
    ('Terms & Condition', 'Terms & Condition'),
    ('App Language', 'App Language'),
    ('Delete Account', 'Delete Account'),
    (
      'Are you sure you want to \nDelete Account ?',
      'Are you sure you want to \nDelete Account ?'
    ),
    (
      'Are you sure you want to \nLogout Account?',
      'Are you sure you want to \nLogout Account?'
    ),
    ('Cancle', 'Cancle'),
    ('Logout', 'Logout'),
    ('First Name', 'First Name'),
    ('Last Name', 'Last Name'),
    ('Email Address', 'Email Address'),
    ('Mobile Number', 'Mobile Number'),
    ('Submit', 'Submit'),
    ('Profile Photo', 'Profile Photo'),
    ('Camera', 'Camera'),
    ('Apply', 'Apply'),
    (
      'How was Your Experience with this place?',
      'How was Your Experience with this place?'
    ),
    ('Write Your Review....', 'Write Your Review....'),
    ('Send', 'Send'),
    ('Please add rat', 'Please add rat'),
    ('Please write your review', 'Please write your review'),
    ('Add Campaign', 'Add Campaign'),
    ('Add New Campaign', 'Add New Campaign'),
    ('Campaigns', 'Campaigns'),
    (
      'You don’t have any campaigns \n start creating one',
      'You don’t have any campaigns \n start creating one'
    ),
    ('Please select campaigns', 'Please select campaigns'),
    ('Next', 'Next'),
    ('Budget & duration', 'Budget & duration'),
    ('What’s your ad budget?', 'What’s your ad budget?'),
    (
      'Excludes apple service fee and applicable taxes',
      'Excludes apple service fee and applicable taxes'
    ),
    ('Start Date', 'Start Date'),
    ('End Date', 'End Date'),
    ('Daily Budget', 'Daily Budget'),
    ('Days', 'Days'),
    ('30 Days', '30 Days'),
    (
      'Please select both Start Date and End Date',
      'Please select both Start Date and End Date'
    ),
    ('Price Details', 'Price Details'),
    ('Total Days', 'Total Days'),
    ('Start Date / End Date', 'Start Date / End Date'),
    ('Price Details', 'Price Details'),
    ('Selected Ad Days', 'Selected Ad Days'),
    ('Tax/GST', 'Tax/GST'),
    ('Platform Charges', 'Platform Charges'),
    ('Total Amount', 'Total Amount'),
    ('Make Payment', 'Make Payment'),
    ('Select Preferred Payment', 'Select Preferred Payment'),
    ('Credit or Debit Card', 'Credit or Debit Card'),
    ('PayPal', 'PayPal'),
    ('Gpay', 'Gpay'),
    ('Razorpay', 'Razorpay'),
    ('Payment success', 'Payment success'),
    ('Payment successful!', 'Payment successful!'),
    ('Thank you for your transaction.', 'Thank you for your transaction.'),
    (
      ' Enter your business name exactly how you would like it to look to all users.',
      ' Enter your business name exactly how you would like it to look to all users.'
    ),
    ('Business Description', 'Business Description'),
    (
      'Please add you business description',
      'Please add you business description'
    ),
    ('Select Year', 'Select Year'),
    ('Select Store', 'Select Store'),
    ('Month', 'Month'),
    (
      'Please select your business startup year',
      'Please select your business startup year'
    ),
    (
      'Please select your business start month',
      'Please select your business start month'
    ),
    (
      ' Please note that any changes to the details below can go for verification and take upto 2 working days to go live.',
      ' Please note that any changes to the details below can go for verification and take upto 2 working days to go live.'
    ),
    ('Number of Employees', 'Number of Employees'),
    (
      ' Please select the number of employees at your company',
      ' Please select the number of employees at your company'
    ),
    ('Select Number of Employees', 'Select Number of Employees'),
    ('Please select  number of emplyees', 'Please select  number of emplyees'),
    ('Business categories', 'Business categories'),
    (
      ' Categories describe what your business is and the products abd services your business offers. please add atleast one category for customers to find your business',
      ' Categories describe what your business is and the products abd services your business offers. please add atleast one category for customers to find your business'
    ),
    ('Categories', 'Categories'),
    ('Sub Categories', 'Sub Categories'),
    ('Please select category', 'Please select category'),
    ('Please select subcategory', 'Please select subcategory'),
    (
      ' Enter the address details that would be used by customers to locate your workplace',
      ' Enter the address details that would be used by customers to locate your workplace'
    ),
    ('Please add your business address', 'Please add your business address'),
    ('Profile ', 'Profile '),
    ('Hello welcome to Nlytical app', 'Hello welcome to Nlytical app'),
    ('Continue with Login', 'Continue with Login'),
    ('Continue As Guest', 'Continue As Guest'),
    (
      'Discover more about our app by registering',
      'Discover more about our app by registering'
    ),
    ('or logging in', 'or logging in'),
    ('Password', 'Password'),
    ('Sign In', 'Sign In'),
    ('Continue with Google', 'Continue with Google'),
    ('Continue with Number', 'Continue with Number'),
    ('Don’t have an account? ', 'Don’t have an account? '),
    ('Sign Up', 'Sign Up'),
    ('Remember me', 'Remember me'),
    ('Forgot Password ?', 'Forgot Password ?'),
    ('Or', 'Or'),
    ('User Name', 'User Name'),
    ('Enter Your Mobile Number', 'Enter Your Mobile Number'),
    ('Sign In', 'Sign In'),
    ('Please Enter Your Password', 'Please Enter Your Password'),
    (
      'Password must be at least 8 characters long',
      'Password must be at least 8 characters long'
    ),
    (
      'Password must contain at least one uppercase letter',
      'Password must contain at least one uppercase letter'
    ),
    (
      'Password must contain at least one lowercase letter',
      'Password must contain at least one lowercase letter'
    ),
    (
      'Password must contain at least one number',
      'Password must contain at least one number'
    ),
    (
      'Password must contain at least one special character',
      'Password must contain at least one special character'
    ),
    ('8 or more character ', '8 or more character '),
    ('1 number ', '1 number '),
    ('1 Uppercase ', '1 Uppercase '),
    ('1 LowerCase ', '1 LowerCase '),
    ('1 special character ', '1 special character '),
    ('Get OTP', 'Get OTP'),
    ('Verification Code', 'Verification Code'),
    (
      'We have sent the code verification',
      'We have sent the code verification'
    ),
    ('to your Mobile Number', 'to your Mobile Number'),
    ('to your Email Address', 'to your Email Address'),
    ('Resend OTP', 'Resend OTP'),
    ('Resend Code in', 'Resend Code in'),
    ('New Password', 'New Password'),
    ('Confirm Password', 'Confirm Password'),

    // ----------------------------------------------------------------------------USER-------------------------------------------------------------------------------------

    ('Hello, Guest', 'Hello, Guest'),
    ('Search Services...', 'Search Services...'),
    ('Category', 'Category'),
    ('No Category Found', 'No Category Found'),
    ('Nearby Stores', 'Nearby Stores'),
    ('Please login to like this service', 'Please login to like this service'),
    ('No Nearby Store Found', 'No Nearby Store Found'),
    ('Find Your Perfect Store', 'Find Your Perfect Store'),
    ('See all', 'See all'),
    ('No Perfect Store Found', 'No Perfect Store Found'),
    ('Explore', 'Explore'),
    ('Listing', 'Listing'),
    ('Location', 'Location'),
    ('Please login to like this service', 'Please login to like this service'),
    ('From', 'From'),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
    ('', ''),
  ];
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
