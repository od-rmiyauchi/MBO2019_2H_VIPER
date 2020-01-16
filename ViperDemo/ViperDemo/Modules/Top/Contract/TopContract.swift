//
//  TopContract.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import UIKit

protocol TopView: class {
    var presenter: TopPresentation! { get set }
    
    func showCityCells(_ cityViewModel: CityViewModel)
}

protocol TopPresentation: class {
    var cityInteractor: TopCityUsecase! { get set }
    var router: TopWireframe! { get set }
    
    func viewDidLoad()
    func didSelectCity(_ city: CityCellInfo)
}

protocol TopCityUsecase: class {
    func fetchCities()
}

protocol TopInteractorOutput: class {
    func cityFetched(_ cities: [CityEntity])
    func cityFetchFailed()
}

protocol TopWireframe: class {
    func presentWeather(cityId: String)
    
    static func assembleModule() -> UIViewController
}
