//
//  SceneDelegate.swift
//  weather-app
//
//  Created by tinhpv4 on 6/29/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            
            let weatherController = WeatherController()
            window.rootViewController = UINavigationController(rootViewController: weatherController)
            window.makeKeyAndVisible()
        }
    }
}

