//
//  FakeMoyaService.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 06.12.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation
import Moya

enum FakeMoyaService {
    case getObjectData(objectId: Int)
    case getPictures
}

extension FakeMoyaService: TargetType {
    var baseURL: URL {
        return URL(string: "https://fakeserver.ru")!
    }
    
    var path: String {
        switch self {
        case .getObjectData:
            return "/object"
        case .getPictures:
            return "/pictures"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getObjectData:
            return .get
        case .getPictures:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getObjectData(let objectId):
            let data = FakeDataFactory.getData(by: objectId)
            guard let encodedData = try? JSONEncoder().encode(data) else { return Data() }
            return encodedData
        case .getPictures:
        let data = FakeDataFactory.getPictures()
        guard let encodedData = try? JSONEncoder().encode(data) else { return Data() }
        return encodedData
        }
    }
    
    var task: Task {
        switch self {
        case .getObjectData:
            return .requestPlain
        case .getPictures:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getObjectData:
            return [:]
        case .getPictures:
        return [:]
        }
    }
    
}
