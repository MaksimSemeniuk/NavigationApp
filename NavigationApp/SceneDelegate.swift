//
//  SceneDelegate.swift
//  NavigationApp
//
//  Created by Maksim Semeniuk on 09.06.2021.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // If user not authorized - show login screen
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PhoneLoginViewController")
            setRootViewController(vc)
        }

    }

    private func setRootViewController(_ vc: UIViewController) {
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }


}

