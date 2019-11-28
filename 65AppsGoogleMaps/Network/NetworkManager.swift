//
//  NetworkManager.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation
import Moya
import Result

protocol NetworkDataProvider: class {
    func getCoordinates(completion: @escaping (CoordinatesModel?, Error?) -> Void)
}

class NetworkManager: NetworkDataProvider {

let provider = MoyaProvider<MoyaService>()
    
    func getCoordinates(completion: @escaping (CoordinatesModel?, Error?) -> Void) {
        provider.request(.getCoordinates) { [weak self] result in
            guard let self = self else { return }
            do {
                let data = try self.handleResult(result: result, type: CoordinatesModel.self)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}

extension NetworkManager {
    
    private func handleResult<T: Codable>(result: Result<Moya.Response, MoyaError>, type: T.Type) throws -> T {
        switch result {
        case .success(let response):
            return try decodeData(data: response.data, to: type.self)
        case .failure(let error):
            throw error
        }
    }
    
    private func decodeData<T: Codable>(data: Data, to structure: T.Type) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(structure.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
