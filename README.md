<h1> Foodies <h1>

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
After development of this project, Travel Agency can Grow their business online.  
Basically this platform provide any Travel Agency to bring their business online.
  
## Scope
	Mobile apps playing the role as a key lifestyle factor for majority of population..
	A variety of popular cuisines and cosmopolitan tastes to try different food delicacies. 
	A thriving food scene with a variety of quality restaurants serving delicacies with different price tags. 
	Increasing demand for faster and timely food delivery. 
	Competitive pricing aggravated by promotional offers and discounts being a key motivation for the customers.

## Tools and Technologies
VS CODE</br>
Flutter SDK</br>
Dart Extension</br></br></br>
Firebase</br></br>
Many flutter plugins like shared preferences,firebase_auth,etc.</br>


## Project Description


As Project Definition states that “Online Food App” is an online marketplace that connects a Foodies to multiple local Restaurants.
	There are mainly two users :-</br>
	Restaurant(Admin)</br>
	People who order online food(Foodies)</br>
	Both the App modules are build using Flutter.</br>



## Software and Hardware Requirements 
<h3> Software and hardware requirements for making the Project: </h3>
	Operating System:</br>
	Microsoft Windows 7, 64-bit</br>
	Microsoft Windows 8.1, 64-bit</br>
	Microsoft Windows 10, 64-bit</br>
	Hardware:</br>
	Intel® Core i5 4th generation (or an equivalent AMD processor)</br>
	2 GB Ram</br>
	Software</br>
	VS CODE</br>
	Flutter SDK</br>
	Dart Extensions</br>
	Emulator iOS/Android</br>

<h3> Software requirements for running the App: </h3> 
	I Android 6.0 Marshmallow or Above</br>
	IOS 10</br>
	Internet Accessibility</br>
	
<h3> Hardware requirements for running the App: </h3>
	The absolute minimum requirements for our project were a 1 GB of RAM.</br>
	45 MB of storage is required minimum.</br>
 
 
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
	https://stackoverflow.com/questions/tagged/flutter
