//
//  AppDelegate.swift
//  YADI
//
//  Created by deanWombourne on 04/09/2022.
//  Copyright (c) 2022 deanWombourne. All rights reserved.
//

import Foundation
import UIKit

import YADI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Container.shared.add {
            return ViewModel(value: "Hello")
        }

        print("Generators:")
        print(Container.shared.listGenerators().joined(separator: "\n"))
        print("-----------")

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
