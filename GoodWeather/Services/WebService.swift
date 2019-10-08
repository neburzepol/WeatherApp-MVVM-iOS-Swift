//
//  WebService.swift
//  GoodWeather
//
//  Created by Ali Lopez Galaviz on 10/8/19.
//  Copyright © 2019 Ali López Galaviz. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class WebService {
    
    func load<T>(resource: Resource<T>, completion:  @escaping (T?)->()) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let data = data {
                print(data)
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            }else {
                completion(nil)
            }
        }.resume()
    }
    
}
