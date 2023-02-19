//
//  ServiceDetailsController.swift
//  servicesProject
//
//  Created by Ainur on 19.02.2023.
//

import Foundation
import UIKit

class ServiceDetailsController: UIViewController {
    @IBOutlet private weak var serviceImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var linkTextView: UITextView!
    var model: Service?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = model?.name
        descriptionLabel.text = model?.description
        linkTextView.text = model?.service_url
        if let urlString = model?.icon_url, let url = URL(string: urlString) {
            showImage(from: url)
        }
    }
    
    private func showImage(from url: URL) {
        Task {
            serviceImageView.image = try await Networking.getImage(from: url)
        }
    }
    
}


