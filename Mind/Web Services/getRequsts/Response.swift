//
//  Response.swift
//
//
//  Created by Adel Aref.
//  Copyright © 2018 zetta. All rights reserved.
//

import Foundation
/// An enum that holds common network errors.
public enum NetworkError: Error{
    case noConnection
    case noData
    case notFound
    case unAuthorized
    case serverError
    case timeout
    case unknownError
    case badRequestError

    init(with statusCode: Int) {
        switch statusCode {
        case 404:
            self = .notFound
        case 401:
            self = .unAuthorized
        case 400:
            self = .badRequestError
        case 500:
            self = .serverError
        default:
            self = .unknownError
        }
    }

    init(with error: Error) {
        let error = error as NSError
        if error.domain == NSURLErrorDomain{
            switch error.code {
            case NSURLErrorNotConnectedToInternet:
                self = .noConnection
            case NSURLErrorTimedOut:
                self = .timeout
            default:
                self = .unknownError
            }
        }
        else{
            self = .unknownError
        }
    }
}

/// This enum is responsible for extracting the request data from the network response, it is also responsible for translating any status code, network error, to app specfic errors.
public enum Response {
    case json(json: [String: Any]?)
    case data(data: Data)
    case error(error: NetworkError)

    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
        self = .json(json: nil)



        guard response.r?.statusCode == 200, response.error == nil else{
            if let error = response.error{
                let error = NetworkError(with: error)
                self = .error(error: error)
                print("\(error) 1")
            }
            else{
                if let r = response.r {
                    let error = NetworkError(with: r.statusCode)
                    self = .error(error: error)
                    print("\(error) 2")
                }
                else{
                    self = .error(error: .unknownError)
                    print("unknown 3")
                }
            }
            return
        }


        guard let data = response.data else{
            self = .error(error: .noData)
            print("nodata 4")
            return
        }

        print("Success +++",data)


        switch request.dataType {
        case .JSON:
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self = .json(json: json)
            }
            catch{
                self = .error(error: .unknownError)
            }
 
        case .Data:
            self = .data(data: data)
        }
    }

}
///////

public enum HTTPMethod:String{
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}


public enum RequestParameters{
    case url(_ : [String: Any]?)
    case body(_ :[String: Any]?)
}

public enum DataType {
    case JSON
    case Data
}

/// A simple protocol to that holds the request related properties
public protocol Request {
    var path: String {get}
    
    var pathContainsHost: Bool {get}
    
    var method: HTTPMethod {get}
    
    var parameters: RequestParameters {get}
    
    var headers: [String: Any]? {get}
    
    var dataType: DataType {get}
}


