//
//  RootRouter.swift
//  ViperDemo
//
//  Created by 宮内 龍之介 on 2019/12/09.
//  Copyright © 2019 宮内 龍之介. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    func presentTopScreen(in window: UIWindow) {
        window.rootViewController = TopRouter.assembleModule()
        window.makeKeyAndVisible()
    }
}
