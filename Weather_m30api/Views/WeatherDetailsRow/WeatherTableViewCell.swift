//
//  WeatherDetailsTableViewCell.swift
//  Weather_m30api
//
//  Created by muslim on 22.03.2023.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let reuseIdentifier = "WeatherCell"

    private let dateLabel = UILabel()
    private let highTemperatureLabel = UILabel()
    private let lowTemperatureLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // should change to a normal StackView
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        highTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        contentView.addSubview(highTemperatureLabel)
        contentView.addSubview(lowTemperatureLabel)
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            highTemperatureLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8),
            highTemperatureLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            lowTemperatureLabel.leadingAnchor.constraint(equalTo: highTemperatureLabel.trailingAnchor, constant: 8),
            lowTemperatureLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: lowTemperatureLabel.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: lowTemperatureLabel.bottomAnchor, constant: 8)
        ])
        
        // configure
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        highTemperatureLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lowTemperatureLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with forecast: WeatherForecast) {
        dateLabel.text = forecast.date
        highTemperatureLabel.text = "\(Int(forecast.maxTempC.rounded()))°"
        lowTemperatureLabel.text = "\(Int(forecast.minTempC.rounded()))°"
    }

}

