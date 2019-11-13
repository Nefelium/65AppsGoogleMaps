//
//  NetworkManager.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation
import Moya

class NetworkManager {

let provider = MoyaProvider<MoyaService>()

    private func decodeData<T: Codable>(data: Data, to structure: T.Type) -> T? {
        guard let decodedData = try? JSONDecoder().decode(structure.self, from: data) else {
            print("Something gone wrong while decoding...")
            return nil
        }
        return decodedData
    }
    
    func getCoordinates<T: Codable>(output structure: T.Type, completion: @escaping (T) -> Void) {
        provider.request(.getCoordinates) { [weak self] result in
            guard let self = self else { return }
             switch result {
             case .success(let response):
                guard let decodedData = self.decodeData(data: response.data, to: T.self) else { return }
                completion(decodedData)
             case .failure(let error):
                 print(error.errorDescription ?? "Something gone wrong...")
             }
        }
    }
}
