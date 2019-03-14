# Streams Test App

Streams is an ios app that allow you to see the list of all the movies ever created about Batman, the Marvel superhero over the years.


## Getting Started

After cloning the app code, streams uses carthage to manage third party libraries you will have to install carthage if you have not previously installed it (check installation process bellow).
Streams makes use of the OMDb api to pull and fetch the list of available movies in this api apttern 
The app gets the data from a sample API that is accessible through the endpoint http://www.omdbapi.com/?apikey=your-key&t=movie-title&y=movie-year.

The full description of the API is available at ​http://www.omdbapi.com/


### Prerequisites

You will require the following installed and available to able to run the app

```
Xcode 10.1+
Swift 4.2+ 
Carthage
```

### Installing

Once imported into XCode 

Install/Update all Carthage Dependencies to install visit https://github.com/Carthage/Carthage to for step by step intruction. Then run

```
Carthage update --platform iOS
```
Add libraryName.framwework build in the Build folder of carthage are linked in the Xcode project build settings

Then

```
Run The App From XCode
```

Note: 


## 3rd Party Depencies

* [Alamofire](https://github.com/Alamofire/Alamofire) - Elegant HTTP Networking in Swift
* [RxSwift](https://github.com/ReactiveX/RxSwift) - Reactive Programming in Swift

###AlamoFire
I chose to use this library because of the fllowing
* Fast to use and work with
* Its is well documented
* And less boiler code to deal with
* It supports parsing of json response to models using codable

###RxSwift
The choice for using RxSwift give me a better interface communication between the model layer and Views, and its widely used acros serval plaforms.
Although it require some bit of skill and getting used to but once you have a one of one of the Rx Libs you can work with most other Reative Frameworks

## Authors

* **Lekan Oladosu** -(https://github.com/culjo)

## License

This project is not lincensed for now
