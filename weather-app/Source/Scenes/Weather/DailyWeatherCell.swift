//
//  DailyWeatherCell.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import UIKit
import Kingfisher

class DailyWeatherCell: UITableViewCell, NameIdentifiable {
    private var dateLabel: UILabel!
    private var tempLabel: UILabel!
    private var pressureLabel: UILabel!
    private var humidityLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var weatherIcon: UIImageView!
    
    var weather: Weather? {
        didSet {
            configureCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initUI() {
        contentView.backgroundColor = .backgroundColor
        dateLabel = UILabel(frame: .zero)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        tempLabel = UILabel(frame: .zero)
        tempLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        pressureLabel = UILabel(frame: .zero)
        pressureLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        humidityLabel = UILabel(frame: .zero)
        humidityLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        weatherIcon = UIImageView(frame: .zero)
        weatherIcon.prepareForConstraints()
        
        let vStack = UIStackView(frame: .zero)
        vStack.prepareForConstraints()
        vStack.axis = .vertical
        vStack.spacing = 15.0
        vStack.addArrangedSubview(dateLabel)
        vStack.addArrangedSubview(tempLabel)
        vStack.addArrangedSubview(pressureLabel)
        vStack.addArrangedSubview(humidityLabel)
        vStack.addArrangedSubview(descriptionLabel)
        vStack.pinEdges(to: contentView, equalTo: .init(top: 15, left: 15, bottom: 15))
        
        weatherIcon.pinEdges(to: contentView, equalTo: .init(right: 15))
        weatherIcon.center(.vertically, in: vStack)
        weatherIcon.constraintTo(width: 70, height: 70)
        weatherIcon.chain(.horizontally, to: vStack, with: 15)
    }
    
    private func configureCell() {
        guard let weather = self.weather else { return }
        dateLabel.text = "Date: \((weather.date ?? 0).convertToFormat())"
        tempLabel.text = "Average Temperature: \(weather.avgTemparature ?? 0)°C"
        pressureLabel.text = "Pressure: \(weather.pressure ?? 0)"
        humidityLabel.text = "Humidity: \(weather.humidity ?? 0)%"
        descriptionLabel.text = "Description: " + (weather.description ?? "")
        weatherIcon.kf.setImage(with: weather.iconUrl)
    }
}
