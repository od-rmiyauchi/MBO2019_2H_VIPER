//
//  WeatherAPI.swift
//  RxSwiftDemo
//
//  Created by 宮内 龍之介 on 2019/12/03.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import Foundation

import RxSwift
import Alamofire

class WeatherAPI {
    static func createForecastObservable(_ url: String, _ parameters: [String:Any]) -> Single<WeatherEntity> {
        return Single<WeatherEntity>.create { (observer) -> Disposable in
            Alamofire
                .request(url, method: .get, parameters: parameters)
                .response(completionHandler: { (response) in
                    if let error = response.error {
                        observer(.error(error))
                    }
                    
                    guard let data = response.data else {
                        observer(.error(WeatherAPIError.emptyData))
                        return;
                    }
                    
                    let decoder = JSONDecoder()
                    if let weatherEntity = try? decoder.decode(WeatherEntity.self, from: data) {
                        observer(.success(weatherEntity))
                    } else {
                        observer(.error(WeatherAPIError.parseJson))
                    }
                    
                })
            return Disposables.create()
        }
    }
}
