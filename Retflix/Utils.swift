//
//  Utils.swift
//  Retflix
//
//  Created by RENO1 on 2020/11/02.
//

import Foundation

class Utils {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dataFormatter)
        return jsonDecoder
    }()
    
    static let dataFormatter: DateFormatter = {
       let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-mm-dd"
        return dataFormatter
    }()
}
