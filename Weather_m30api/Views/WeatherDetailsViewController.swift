//
//  WeatherDetailsViewController.swift
//  Weather_m30api
//
//  Created by muslim on 21.03.2023.
//

import UIKit


class WeatherDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private var viewModel = HomeViewModel()
    private let weatherForecasts: [Forecast] = []
    
    private lazy var weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.register(WeatherDetailsCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        view.addSubview(weatherTableView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
    
}
