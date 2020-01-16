//
//  WeatherPresenter.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import Foundation

class WeatherPresenter: WeatherPresentation {
    weak var view: WeatherView?
    
    var weatherInteractor: WeatherUsecase!
    
    var router: WeatherWireframe!
    
    var cityId: String!
    
    var weatherViewModel: WeatherViewModel? {
        didSet {
            guard let weatherViewModel = weatherViewModel else { return }
            view?.showWeather(weatherViewModel)
        }
    }
    
    func viewDidAppear() {
        weatherInteractor.fetchWeather(cityId: cityId)
    }
}

extension WeatherPresenter: WeatherInteractorOutput {
    func weatherFetched(_ weather: WeatherEntity) {
        if weather.forecasts.isEmpty {
            return
        }
        
        // ここでViewに表示するためのViewModelに変換する
        // 表示するのは今日の天気のみであるため、他は不要
        weatherViewModel = WeatherViewModel(todayForecast: weather.forecasts[0].telop)
    }
    
    func weatherFetchFailed() {
    }
}
