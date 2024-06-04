//
//  KeychainManager.swift
//  TestAuthSIS
//
//  Created by Миша Вашкевич on 04.06.2024.
//

import Foundation
import KeychainSwift

protocol KeychainManagerProtocol {
    
    var name: String { get }
    
    func getPassword(completion: @escaping (Result<String, Error>) -> Void)
    func savePassword(code: String)
    func updatePassword(code: String)
}

final class KeychainManager: KeychainManagerProtocol {
    
    let storage = KeychainSwift()
    
    var name: String = "KeychainStorage"
    
    func getPassword(completion: @escaping (Result<String, Error>) -> Void) {
        storage.clear()
        guard let data = storage.getData("userDataBase9") else {
            completion(.failure(NSError(domain: "DataError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
            return
        }
        do {
            let code = try JSONDecoder().decode(String.self, from: data)
            completion(.success(code))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func savePassword(code: String) {
        do {
            let data = try JSONEncoder().encode(code)
            storage.set(data, forKey: "userDataBase9")
        } catch let error {
            print("encode error \(error)")
        }
    }
    
    func updatePassword(code: String) {
        savePassword(code: code)
    }

}
