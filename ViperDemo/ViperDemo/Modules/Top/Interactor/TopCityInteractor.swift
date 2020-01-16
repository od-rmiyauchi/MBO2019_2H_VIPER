//
//  TopInteractor.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import Foundation
import RxSwift

class TopCityInteractor: TopCityUsecase {
    weak var output: TopInteractorOutput!
    private var disposeBag = DisposeBag()
    
    private let cityDataSource: CityDataSource
    
    init(cityDataSource: CityDataSource) {
        self.cityDataSource = cityDataSource
    }
    
    func fetchCities() {
        cityDataSource
            .getCities(disposeBag: disposeBag,
                       onSuccess: { (cities) in
                            self.output.cityFetched(cities)
            },
                       onError: { (error) in
                            self.output.cityFetchFailed()
            })
    }
}
