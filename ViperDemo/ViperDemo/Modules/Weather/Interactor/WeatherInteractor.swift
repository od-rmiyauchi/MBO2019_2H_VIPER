//
//  WeatherInteractor.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import Foundation
import RxSwift

class WeatherInteractor: WeatherUsecase {
    weak var output: WeatherInteractorOutput!
    private var disposeBag = DisposeBag()
    
    private let weatherDataSource: WeatherDataSource
    
    init(weatherDataSource: WeatherDataSource) {
        self.weatherDataSource = weatherDataSource
    }
    
    func fetchWeather(cityId: String) {
        weatherDataSource
            .getForecast(cityId: cityId,
                         disposeBag: disposeBag,
                         onSuccess: { (weather) in
                            self.output.weatherFetched(weather)
        },
                         onError: { (error) in
                            self.output.weatherFetchFailed()
        })
    }
}
