//
//  WeatherContract.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import UIKit

protocol WeatherView: class {
    var presenter: WeatherPresentation! { get set }
    
    func showWeather(_ weather: WeatherViewModel)
}

protocol WeatherPresentation: class {
    var router: WeatherWireframe! { get set }
    
    func viewDidAppear()
}

protocol WeatherUsecase: class {
    func fetchWeather(cityId: String)
}

protocol WeatherInteractorOutput: class {
    func weatherFetched(_ weather: WeatherEntity)
    func weatherFetchFailed()
}

protocol WeatherWireframe: class {
    static func assembleModule(cityId: String) -> UIViewController
}
