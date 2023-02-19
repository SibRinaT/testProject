//
//  ServiceCell.swift
//  servicesProject
//
//  Created by Ainur on 19.02.2023.
//

import Foundation
import UIKit

class ServiceCell: UITableViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var serviceImageView: UIImageView!
    
    func configure (with model: Service) {
        nameLabel.text = model.name
        if let urlString = model.icon_url, let url = URL(string: urlString) {
        showImage(from: url)
        } else {
        serviceImageView.image = nil
        }
    }
    
    private func showImage(from url: URL) {
        Task {
            serviceImageView.image = try await Networking.getImage(from: url)
        }
    }
}
