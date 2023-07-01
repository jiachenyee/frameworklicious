//
//  Messagable.swift
//  Air Hockey
//
//  Created by Muhammad Irfan on 21/06/23.
//

import Foundation

protocol Messagable: Codable {    
    func toJSONData() -> Data?
    
    static func from(data: Data) -> Self?
}


extension Messagable {
    func toJSONData() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    static func from(data: Data) -> Self? {
        let decoder = JSONDecoder()
        
        return try? decoder.decode(self, from: data)
    }
}
