# Swift Concurrency
Hello everyone, this is a simple project showcasing different ways to implement concurrent programming in Swift

## Description
This app displays the weather in three different regions you can choose with the dedicated search bar. Once you're happy with the locations you've picked, tapping the Update View button will make three different API calls with the three different ways of making asynchronous calls: DispatchQueue and completion handlers, Async/Await and Combine.

## Installation and usage

1. Clone the project
2. Open it in XCode
3. Build it and run it on the simulator or your iPhone

To effectively test this project you have to do the following, once you've open the app:

1. Write at least one name of a city in the search bar and tap "Search"
2. A message will pop up telling you for which method you've picked the location
3. Tap "OK" to continue
4. Repeat steps 1 to 3 to add more locations (max. 3)
5. Tap "Update View" to make the calls and see the weather info
