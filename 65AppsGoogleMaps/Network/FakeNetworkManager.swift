//
//  FakeNetworkManager.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 06.12.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation
import Moya
import Result

protocol FakeNetworkDataProvider: class {
    func getCoordinates(id: Int, completion: @escaping (Result<ObjectData, Error>) -> Void)
}

class FakeNetworkManager: FakeNetworkDataProvider {

let provider = MoyaProvider<FakeMoyaService>(stubClosure: MoyaProvider.immediatelyStub)
    
    func getCoordinates(id: Int, completion: @escaping (Result<ObjectData, Error>) -> Void) {
        provider.request(.getObjectData(objectId: id)) { [weak self] result in
            guard let self = self else { return }
            do {
                let data = try self.handleResult(result: result, type: ObjectData.self)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

extension FakeNetworkManager {
    
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
