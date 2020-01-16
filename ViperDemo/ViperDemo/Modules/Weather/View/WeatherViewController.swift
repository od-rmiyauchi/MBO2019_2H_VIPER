//
//  WeatherViewController.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var presenter: WeatherPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "今日の天気予報"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewDidAppear()
    }

}

extension WeatherViewController: WeatherView {
    
    func showWeather(_ weather: WeatherViewModel) {
        textView.text = "\(weather.todayForecast)"
    }
}
