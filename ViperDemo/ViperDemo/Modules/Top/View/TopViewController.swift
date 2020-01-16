//
//  TopViewController.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct TopConstant {
    static let showForecastSeque = "showForecast"
    static let cellIdentifier = "cityCell"
}

class TopViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TopPresentation!
    var cityViewModel: CityViewModel?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension TopViewController: TopView {
    func showCityCells(_ cityViewModel: CityViewModel) {
        self.cityViewModel = cityViewModel
        
        tableView.reloadData()
    }
}

extension TopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel?.cellInfos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopConstant.cellIdentifier, for: indexPath)
        if let info = cityViewModel?.cellInfos[indexPath.row] {
            cell.textLabel?.text = info.pref + " - " + info.name
        }
        return cell
    }
}

extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = cityViewModel else { return }
        
        let city = viewModel.cellInfos[indexPath.row]
        presenter.didSelectCity(city)
    }
}
