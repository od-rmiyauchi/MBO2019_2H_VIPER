//
//  WeatherDataSource.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2020/01/10.
//  Copyright © 2020 宮内 龍之介. All rights reserved.
//

import Foundation
import RxSwift

/// 天気情報データソース インタフェース
protocol WeatherDataSource {
    // 天気予報を取得
    func getForecast(cityId: String,
                     disposeBag: DisposeBag,
                     onSuccess: @escaping (WeatherEntity) -> Void,
                     onError: @escaping (Error) -> Void)
}
