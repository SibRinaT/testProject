//
//  Networking.swift
//  servicesProject
//
//  Created by Ainur on 19.02.2023.
//

import Foundation
import UIKit

struct Networking {
    private static let serviceUrl = URL(string: "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json")!
        
    static func getServices() async throws -> [Service] {
        let (data, _) = try await URLSession.shared.data(from: serviceUrl)
        let model = try JSONDecoder().decode(SemifinalDate.self,from: data)
        return model.items ?? []
    }
    
    static func getImage(from url: URL) async throws -> UIImage? {
        let (data, response) = try await URLSession.shared.data(from: url)
        if let response = response as? HTTPURLResponse,
           response.statusCode == 200,
           let mimeType = response.mimeType,
           mimeType.hasPrefix("image"),
           let image = UIImage(data: data)
        {
            return image
        } else {
            return nil
        }
    }
}
 
