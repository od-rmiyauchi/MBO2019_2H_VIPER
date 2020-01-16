//
//  TopRouter.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import UIKit

class TopRouter: TopWireframe {
    weak var viewController: UIViewController?
    
    // Top画面の生成
    static func assembleModule() -> UIViewController {
        let view = UIStoryboard(name: "TopStoryboard", bundle: nil)
            .instantiateViewController(identifier: "TopViewController")
            as? TopViewController
        
        // ModelをDIする
        // 例えば市情報をインターネットから取得するように仕様変更した場合は、ここをCityClientなどに変更する
        let cityDataSource = CityAssets()    // Assetsから市情報を取得
        
        let presenter = TopPresenter()
        let cityInteractor = TopCityInteractor(cityDataSource: cityDataSource)
        let router = TopRouter()
        
        let navigation = UINavigationController(rootViewController: view!)
        
        view?.presenter = presenter
        
        presenter.view = view
        presenter.cityInteractor = cityInteractor
        presenter.router = router

        cityInteractor.output = presenter
        
        router.viewController = view
        
        return navigation
    }
    
    // Top画面 -> 天気画面への遷移
    func presentWeather(cityId: String) {
        let weatherViewController = WeatherRouter.assembleModule(cityId: cityId)
        viewController?.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    
}
