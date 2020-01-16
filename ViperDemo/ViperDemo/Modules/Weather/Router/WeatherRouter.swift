//
//  WeatherRouter.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import UIKit

class WeatherRouter: WeatherWireframe {
    
    weak var viewController: UIViewController?
    
    static func assembleModule(cityId: String) -> UIViewController {
        let view = UIStoryboard(name: "WeatherStoryboard", bundle: nil)
        .instantiateViewController(identifier: "WeatherViewController")
        as WeatherViewController
        
        // ModelをDIする
        // 例えばYahoo天気APIに仕様変更した場合は、ここをYahooWeatherClientなどに変更する
        let weatherDataSouce = LivedoorWeatherClient()    // Livedoor WebAPIで天気予報を取得
        
        let presenter = WeatherPresenter()
        let weatherInteractor = WeatherInteractor(weatherDataSource: weatherDataSouce)
        let router = WeatherRouter()

        view.presenter = presenter
        
        presenter.view = view
        presenter.weatherInteractor = weatherInteractor
        presenter.router = router
        presenter.cityId = cityId

        weatherInteractor.output = presenter
        
        router.viewController = view
        
        return view
    }
    
}
