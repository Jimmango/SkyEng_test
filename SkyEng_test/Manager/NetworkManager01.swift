//
//  NetworkManager01.swift
//  SkyEng_test
//
//  Created by Dima Loria on 17.10.2021.
//

import UIKit

class NetworkManager01 {
    
    static let shared = NetworkManager01()

    private init() {}
    
    func getWords() {
        
        let url = URL(string: "https://dictionary.skyeng.ru/api/public/v1/words/search?search=table")!
        
    //    guard let url = URL(string: endpoint) else {
    //        completion(nil, "Ошибка")
    //        return
    //    }
        
        let task = URLSession.shared.dataTask(with: url) { data, respons, error in
            
            guard error == nil, let data = data else {
                print("Error")
                return
            }
            let words = try? JSONDecoder().decode([Word].self, from: data)
            if let words = words {
                print(words[0].text)
            }
        }
        task.resume()
    }
}
