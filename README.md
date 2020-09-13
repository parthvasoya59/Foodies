<pre><h1> Foodies <h1>

## A Project Report On "Online Food App"

## Prepared by Parth Vasoya 
  
Department of Computer Science & Engineering
Devang Patel Institute of Advance Technology and Research
At: Changa, Dist.: Anand – 388421
June 2020 


## ABSTRACT


Making dynamic application, for restaurant.In this application, I will create two module one for admin, who can add products and get all information about application and other for users,
In that users can add products into cart and after that they can get final bill and buy product and track their product.

## Objective
After development of this project, Travel Agency can Grow their business online  
Basically this platform provide any Travel Agency to bring their business online
  
## Scope
	Mobile apps playing the role as a key lifestyle factor for majority of population..
	A variety of popular cuisines and cosmopolitan tastes to try different food delicacies. 
	A thriving food scene with a variety of quality restaurants serving delicacies with different price tags. 
	Increasing demand for faster and timely food delivery. 
	Competitive pricing aggravated by promotional offers and discounts being a key motivation for the customers.

## Tools and Technologies
VS CODE
Flutter SDK
Dart Extension
Firebase
Many flutter plugins like shared preferences,firebase_auth,etc.


## Project Description


As Project Definition states that “Online Food App” is an online marketplace that connects a Foodies to multiple local Restaurants.
	There are mainly two users :-
	Restaurant(Admin)
	People who order online food(Foodies)
	Both the App modules are build using Flutter.



## Software and Hardware Requirements 
<h3> Software and hardware requirements for making the Project: </h3>
	Operating System:
	Microsoft Windows 7, 64-bit
	Microsoft Windows 8.1, 64-bit
	Microsoft Windows 10, 64-bit
	Hardware:
	Intel® Core i5 4th generation (or an equivalent AMD processor)
	2 GB Ram
	Software
	VS CODE
	Flutter SDK
	Dart Extensions
	Emulator iOS/Android

<h3> Software requirements for running the App: </h3> 
	I Android 6.0 Marshmallow or Above
	IOS 10
	Internet Accessibility
	
<h3> Hardware requirements for running the App: </h3>
	The absolute minimum requirements for our project were a 1 GB of RAM.
	45 MB of storage is required minimum.
 
 
## Major Functionality 
In this project there are two modules based on the users of the app.
<h3> Functionality for User </h3>
	Pages : home page, food page, cart page, status page, admin page,admin order page

	In Homepage, I created all items category list widgets ,frequently bought foods, drawer menu,etc.

	In Item pages, I add all foods which have same category, in this all food items fetch from firebase database. In I create 4 category pages like pizza,burger,sandwich and dessert.

	In food page, when user click on any food item card then navigate to food page. In that food page I include food name,photo,description,price,add to cart button and cart icon where we can check cart.

	In Cart Page, when user add item into cart all item shows in this cart page. This all data fetch from firebase. In this I add one checkout button when user click on that order is placed.

	In Status page, user can show their order status like order placed, order received at admin site, order prepared and order delivered.

<h3> Functionality for Admin </h3>
	In Admin page, in this page admin can add items in database via this page or directly in firebase.

	In Admin order page, when user click on checkout button admin can show all user order in this page.

	In Admin order item page, when user click on user email show in admin order page admin can get all information about that user order like all items name and no. of each items. In this page two buttons are their which are one prepared button and one delivered button, when click on that button user status will update.
 


## Limitations

	Lack of cookies – Many devices do not support storage of cookies, which are now widely used in most application to enhance user experience, facilitating the validation of data entered by the page visitor.
	Integration of payment gateway with online payment service is still pending.
	Some of the functionality still some improvement (they need to be more dynamic) like a user can only edit his profile photo or his other detail one at a time.


## Future Enhancement

	Integrating of payment gateway with banks
	More Dynamic UI 
	Google Map Integration


## References:
	https://pub.dev/packages/cloud_firestore
	https://pub.dev/packages/firebase_auth
	https://pub.dev/packages/shared_preferences
	https://firebase.google.com/
	https://stackoverflow.com/questions/49764905/how-to-assign-future-to-widget-in-flutter
	https://stackoverflow.com/questions/51473292/flutter-project-when-run-showing-error-invalid-arguments-the-source-must-not
	https://flutter.dev/docs/get-started/install/windows
	https://console.firebase.google.com
	https://flutter.dev/docs/development/tools/sdk/upgrading
	https://code.visualstudio.com/download
	https://flutter.dev
	https://stackoverflow.com/questions/tagged/flutter</pre>
