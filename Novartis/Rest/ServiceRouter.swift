//
//  ServiceRouter.swift
//  Novartis
//
//  Created by Tomislav Luketic on 7/20/19.
//  Copyright © 2019 lux. All rights reserved.
//
import Foundation
import Alamofire

enum ServiceRouter: URLRequestConvertible {
    
    static let baseURLPath = "https://novartis.rest.com"
    
    case countryInfo(countryCode:String)
   
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .countryInfo:
            return "/countryInfo"
       
            
        }
    }
    
    var parameters: [String: Any] {
        switch self {
            case .countryInfo(let countryCode):
                return ["country" : countryCode]
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try ServiceRouter.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

