//
//  ApiClient.swift
//  Streams
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Alamofire
import RxSwift

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}


class ApiClient {
    
    static func fetchMovie(title: String, year: String) -> Observable<Movie> {
        return performRxRequest(MoviesEndpoint.fetchMovie(title: title, year: year))
    }
    
    // MARK: - RxRequest
    
    /**
     Using RxSwift to reactivey make our api reqest and to send reaponse feedback.
     This wraps the Alamofire Request and waits for the callback response.
     regardless of the request rxswift is responsible fot communication the changes across the  app.
     - Parameters:
     - urlConvertiable: Build from the Endpoint configuration class.
     - Returns: Observable
     */
    private static func performRxRequest<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        
        // Create an Rxswift observable, which will be the one to call the request when subscribed to
        return Observable<T>.create {
            observer in
            // Trigger the HttpRequest using Alamofire
            let request =  AF.request(urlConvertible)
                //.validate() // matched 200..<300 & Content-Type matches the one set in the request header
                .responseString(completionHandler: { response in print("+++++++++++ STRING RESPONSE ++++++++++ \n \(response)") })
                .responseDecodable { (response: DataResponse<T>) in
                    debugPrint(response)
                    switch response.result {
                    case .success(let value):
                        
                        print("===================== RESPONSE =====================")
                        debugPrint(value)
                        // Cool Everything worked.
                        observer.onNext(value)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        // Somthing went wront, so let's get the status code tight
                        switch response.response?.statusCode {
                        case 403:
                            observer.onError(ApiError.forbidden)
                        case 404:
                            observer.onError(ApiError.notFound)
                        case 409:
                            observer.onError(ApiError.conflict)
                        case 500:
                            observer.onError(ApiError.internalServerError)
                        default:
                            observer.onError(error)
                        }
                        
                    }
            }
            
            print("========= ALAMOFIRE REQUEST ============")
            print(request.debugDescription)
            print("\n\n")
            
            // Finally, we retunr a disposable to stop the request
            return Disposables.create {
                request.cancel()
                
            }
        }
        
    }
}
