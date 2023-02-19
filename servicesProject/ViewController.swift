//
//  ViewController.swift
//  servicesProject
//
//  Created by Ainur on 19.02.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!

    var data = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
    }
    
    @objc private func fetchData() {
        tableView.refreshControl?.endRefreshing()
        Task {
            do {
                data = try await Networking.getServices()
                print(data)
                tableView.reloadData()
            } catch {
                let alert = UIAlertController(title: "Ошибка", message: "что-то пошло не так", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ок", style: .default)
                alert.addAction(okButton)
                present(alert, animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        let model = data[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath {
            if let controller =  segue.destination as? ServiceDetailsController {
                controller.model = data[indexPath.row]
            }
        }
    }
}

