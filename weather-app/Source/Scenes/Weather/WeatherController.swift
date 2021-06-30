//
//  WeatherController.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import UIKit

class WeatherController: UIViewController {
    
    var configurator = WeatherConfiguratorImpl()
    var presenter: WeatherPresenter!
    
    private var tableView: UITableView!
    private var searchController: UISearchController!
    private var spinner = UIActivityIndicatorView(style: .large)
    private lazy var workItem = WorkItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(weatherController: self)
        initUI()
    }
    
    private func initUI() {
        title = "Weather Forecast"
        view.backgroundColor = .backgroundColor
        
        searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        tableView = UITableView(frame: .zero)
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: DailyWeatherCell.identifier)
        tableView.prepareForConstraints()
        tableView.pinEdges(to: view, equalTo: .all(0))
    }
}

extension WeatherController: UISearchBarDelegate {
    func searchBar(_ : UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        workItem.perform(after: 0.5) {
            self.presenter.fetchDailyWeather(for: searchText, within: 7, unit: "metric")
        }
    }
}

extension WeatherController: WeatherView {
    func showLoadingView() {
        tableView.isHidden = true
        startActivityIndicator()
    }
    
    func hideLoadingView() {
        tableView.isHidden = false
        stopActivityIndicator()
    }
    
    func onSuccessFetchWeather() {
        tableView.reloadData()
    }
    
    func onFailure(message: String) {
        showAlert(title: "Oops!", message: message)
    }
}

extension WeatherController: UITableViewDataSource {
    func tableView(_ : UITableView, numberOfRowsInSection _: Int) -> Int {
        return presenter.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.identifier,
                                                       for: indexPath) as? DailyWeatherCell else {
            return UITableViewCell()
        }
        
        cell.weather = presenter.weather(on: indexPath.row)
        return cell
    }
}
