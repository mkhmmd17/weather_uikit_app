//
//  WeatherDetailsViewController.swift
//  Weather_m30api
//
//  Created by muslim on 21.03.2023.
//

import UIKit


class WeatherDetailsViewController: UITableViewController {
    
    
    private let forecast: [Forecast]
    
    init(forecast: [Forecast]) {
        self.forecast = forecast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(WeatherDetailsCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .systemPink

    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let forecastItem = forecast[indexPath.row]
        cell.textLabel?.text = "\(forecastItem.date): \(forecastItem.date)"
        return cell
    }
    
    
}
