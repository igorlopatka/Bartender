//
//  SceneDelegate.swift
//  Bartender
//
//  Created by Igor Łopatka on 08/11/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let mainVC = initViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        navigationBarConfiguration(navigationController)
        
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    private func initViewController () -> UIViewController {
        let vc = DrinkListViewController()
        vc.title = "Bartender"
        return vc
    }
    
    private func navigationBarConfiguration (_ controller: UINavigationController) {
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        controller.navigationBar.tintColor = .secondaryLabel
        controller.navigationBar.backgroundColor = .systemBackground
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            
            navBarAppearance.backgroundColor = .systemBackground
            controller.navigationBar.prefersLargeTitles = true
            controller.navigationBar.standardAppearance = navBarAppearance
            controller.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            controller.edgesForExtendedLayout = []
        }
    }
}

