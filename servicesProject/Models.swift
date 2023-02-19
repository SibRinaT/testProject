//
//  Models.swift
//  servicesProject
//
//  Created by Ainur on 19.02.2023.
//

import Foundation

struct SemifinalDate: Codable {
    let items: [Services]?
    
    struct Services: Codable {
        let name: String?
        let description: String?
        let icon_url: String?
        let service_url: String?
    }
}
