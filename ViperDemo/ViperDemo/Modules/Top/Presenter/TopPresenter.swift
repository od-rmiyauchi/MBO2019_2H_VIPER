//
//  TopPresenter.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import Foundation

class TopPresenter: TopPresentation {
    weak var view: TopView?
    
    var cityInteractor: TopCityUsecase!
    
    var router: TopWireframe!
    
    func viewDidLoad() {
        cityInteractor.fetchCities()
    }
    
    func didSelectCity(_ city: CityCellInfo) {
        router.presentWeather(cityId: city.id)
    }
}

extension TopPresenter: TopInteractorOutput {
    func cityFetched(_ cities: [CityEntity]) {
        // Entityを表示する形式(ViewModel)に変換してViewに渡す
        // Clean Architectureのルールでは、ViewはEntityに依存してはならないため
        var cellInfos: [CityCellInfo] = []
        for city in cities {
            cellInfos.append(CityCellInfo(id: city.id,
                                          name: city.name,
                                          pref: city.pref))
        }
        let viewModel = CityViewModel(cellInfos: cellInfos)
        view?.showCityCells(viewModel)
    }
    
    func cityFetchFailed() {
        
    }
}
