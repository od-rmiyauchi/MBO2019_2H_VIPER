//
//  WeatherNetworkManager.swift
//  RxSwiftDemo
//
//  Created by 宮内 龍之介 on 2019/12/04.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import Foundation
import RxSwift

enum WeatherAPIError: Error {
    case emptyData
    case parseJson
}

/// Weather Hacks Livedoor 天気情報 API
class LivedoorWeatherClient: WeatherDataSource {
    
    private let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    
    func getForecast(cityId: String,
                     disposeBag: DisposeBag,
                     onSuccess: @escaping (WeatherEntity) -> Void,
                     onError: @escaping (Error) -> Void) {
        let parameters = ["city": cityId]
        
        let observable = WeatherAPI.createForecastObservable(WeatherConstant.forecastUrl,
                                                             parameters)
        observable
            .subscribeOn(backgroundScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { (weatherEntity) in
                onSuccess(weatherEntity)
            }) { (error) in
                onError(error)
        }.disposed(by: disposeBag)
    }
    
}
