//
//  ViewController.swift
//  Weather_m30api
//
//  Created by muslim on 20.03.2023.
//

import UIKit
import Combine

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let weatherViewModel = WeatherViewModel()
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
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        
        view.addSubview(locationTextField)
        view.addSubview(daysTextField)
        view.addSubview(displayWeatherButton)
        view.addSubview(spinner)
        setupBindings()
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
            displayWeatherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            
        ])
        
    }
    
    private func setupBindings() {
        weatherViewModel.weatherViewActionPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] action in
                switch action {
                case .loading(let show):
                    self?.showSpinner(show: show)
                case .updateWeather(let forecast):
                    guard let forecast else { return }
                    let tableViewController = WeatherDetailsViewController(forecast: forecast)
                    self?.navigationController?.pushViewController(tableViewController, animated: true)
                case .showAlert(let error):
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func displayWeatherAction() {
        
        guard let location = locationTextField.text,
              let daysText = daysTextField.text,
              let days = Int(daysText) else {
            return
        }
        
        weatherViewModel.fetchWeatherForecast(location: location, days: days)
    }
    
    private func showSpinner(show: Bool) {
        if show {
            print("start", Date())
        } else {
            print("end", Date())
        }
        
        show ? spinner.startAnimating() : spinner.stopAnimating()
    }
}

