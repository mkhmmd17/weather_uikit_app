//
//  ViewController.swift
//  Weather_m30api
//
//  Created by muslim on 20.03.2023.
//

import UIKit
import Combine

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let homeViewModel = WeatherViewModel()
    private var cancellables = Set<AnyCancellable>()

    
    private lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .red
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter city name"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 12
        return textField
    }()
    
    
    private lazy var daysTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .blue
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.placeholder = "   Enter days count"
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.delegate = self
        return textField
    }()
    
    private lazy var displayWeatherButton: UIButton = {
        let button = UIButton()
        button.setTitle("Display Weather", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(displayWeatherAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        
        view.addSubview(locationTextField)
        view.addSubview(daysTextField)
        view.addSubview(displayWeatherButton)
        addConstraints()
        
    }
    
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 3),
            locationTextField.heightAnchor.constraint(equalToConstant: 40),
            locationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            daysTextField.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 24),
            daysTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            daysTextField.heightAnchor.constraint(equalToConstant: 40),
            daysTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            displayWeatherButton.topAnchor.constraint(equalTo: daysTextField.bottomAnchor, constant: 20),
            displayWeatherButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            displayWeatherButton.heightAnchor.constraint(equalToConstant: 40),
            displayWeatherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
            
        ])
        
    }
    
    @objc private func displayWeatherAction() {
        
        
        guard let location = locationTextField.text,
                 let daysText = daysTextField.text,
                 let days = Int(daysText) else {
               return
           }

        homeViewModel.fetchWeatherForecast(location: location, days: days)
        
        // Bind the tableView VC
        homeViewModel.$forecasts
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { forecast in
                guard let forecast = forecast else { return }
                let tableViewController = WeatherDetailsViewController(forecast: forecast)
                self.present(tableViewController, animated: true)
            })
            .store(in: &cancellables)
    }
    
}

