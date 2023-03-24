//
//  ViewController.swift
//  Weather_m30api
//
//  Created by muslim on 20.03.2023.
//

import UIKit
import Combine

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let homeViewModel = HomeViewModel()
    
    private lazy var cityNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .red
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter city name"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 12
        return textField
    }()
    
    
    private lazy var daysCountTextField: UITextField = {
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
        
        view.addSubview(cityNameTextField)
        view.addSubview(daysCountTextField)
        view.addSubview(displayWeatherButton)
        addConstraints()
        
    }
    
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            cityNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 3),
            cityNameTextField.heightAnchor.constraint(equalToConstant: 40),
            cityNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cityNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            daysCountTextField.topAnchor.constraint(equalTo: cityNameTextField.bottomAnchor, constant: 24),
            daysCountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            daysCountTextField.heightAnchor.constraint(equalToConstant: 40),
            daysCountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            displayWeatherButton.topAnchor.constraint(equalTo: daysCountTextField.bottomAnchor, constant: 20),
            displayWeatherButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            displayWeatherButton.heightAnchor.constraint(equalToConstant: 40),
            displayWeatherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
            
        ])
        
    }
    
    @objc private func displayWeatherAction() {
        
        guard let cityName = cityNameTextField.text else {
            print("Please enter the city name")
            return
        }
        
        guard let daysCount = Int(daysCountTextField.text ?? "1") else { return }
        
        
        
        homeViewModel.fetchWeatherForecast(location: cityName, days: daysCount)
        
        
//        let vc = WeatherDetailsViewController()
//        self.present(vc, animated: true, completion: nil)
        
    }
    
}

