//
//  MoyaService.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation
import Moya

enum MoyaService {
    case getCoordinates
}

extension MoyaService: TargetType {
    
    var baseURL: URL { return URL(string: "http://www.mocky.io/v2")! }
    var path: String {
        switch self {
        case .getCoordinates:
            return "/5dba84fb3000008c00028f3b"
        }
    }

    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
}
