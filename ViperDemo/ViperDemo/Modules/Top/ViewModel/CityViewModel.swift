//
//  CityViewModel.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2020/01/16.
//  Copyright © 2020 宮内 龍之介. All rights reserved.
//

import Foundation

struct CityCellInfo {
    let id: String
    let name: String
    let pref: String
}

struct CityViewModel {
    let cellInfos: [CityCellInfo]
}
