//
//  CityProtocol.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2020/01/10.
//  Copyright © 2020 宮内 龍之介. All rights reserved.
//

import Foundation
import RxSwift

/// 市情報データソース インタフェース
protocol CityDataSource {
    /// 市情報一覧を取得
    func getCities(disposeBag: DisposeBag,
                   onSuccess: @escaping ([CityEntity]) -> Void,
                   onError: @escaping (Error) -> Void)
}
