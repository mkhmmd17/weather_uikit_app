//
//  WeatherDetailsTableViewCell.swift
//  Weather_m30api
//
//  Created by muslim on 22.03.2023.
//

import UIKit

class WeatherDetailsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .green
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
