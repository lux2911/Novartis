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
    case login(userName:String, pass:String)
    case invitationLogin(code:String)
    case newUser(newUserData: NewUserData)
    
    var method: HTTPMethod {
        switch self {
        case .newUser:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .countryInfo:
            return "/countryInfo"
        case .login:
            return "/login"
        case .invitationLogin:
            return "/invitationLogin"
        case .newUser:
            return "/newUser"
            
        }
    }
    
    var parameters: [String: Any] {
        switch self {
            case .countryInfo(let countryCode):
                return ["country" : countryCode,
                        "accessToken": LoginManager.userData!.accessToken]
            case .login(let userName, let pass):
                return ["username" : userName, "pass" : pass]
            case .invitationLogin(let code):
                return ["code" : code]
           case .newUser(let newUserData):
                let data = try! JSONEncoder().encode(newUserData)
                return ["body" : data]
             }
                
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try ServiceRouter.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        if request.httpMethod == "POST" {
            request.httpBody = parameters["body"] as? Data
            return request
        }
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

