//
//  NetworkManager.swift
//  SkyEng_test
//
//  Created by Dima Loria on 10.10.2021.
//

import UIKit


class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL = "https://dictionary.skyeng.ru/"

    private init() {}
    
    func getWords( word: String, completion: @escaping([Word]?, String?) -> Void) {
        let endpoint = baseURL + "api/public/v1/words/search?search=\(word)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, "Ошибка")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(nil,"Нет доступа к интернету")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Нет ответа с сервера")
                return
            }
            
            guard let data = data else {
                completion(nil, "Данные с сервера недействительны")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let word = try decoder.decode([Word].self, from: data)
                completion(word, nil)
            } catch {
                completion(nil, "Данные с сервера недействительны")
            }
        }
        task.resume()
    }
}


