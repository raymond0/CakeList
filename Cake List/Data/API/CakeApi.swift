//
//  CakeApi.swift
//  Cake List
//
//  Created by Ray Hunter on 22/04/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

@objcMembers
class CakeApi: NSObject {

    static let shared = CakeApi()
    
    private override init(){
        super.init()
    }
    
    let CAKE_RESOURCE_PATH = "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"
    
    //
    // For full swift project I would use "typealias CakeResult = Result<CakeList, Error>"
    //
    // I would normally use AlamoFire. This is a better library to support encoding and
    // decoding, likely to be needed for future changes.
    //
    func loadCakeData(completion: @escaping ([Cake]?, Error?) -> ()){
        guard let url = URL(string: CAKE_RESOURCE_PATH) else {
            completion(nil, NSError(domain: "Cake", code: 0, userInfo:nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let responseData = data else {
                completion(nil, NSError(domain: "Cake", code: 1, userInfo:nil))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cakeArray = try decoder.decode([Cake].self, from: responseData)
                completion(cakeArray, nil)
            } catch (let error){
                completion(nil, error)
            }
        }.resume()
    }
}
