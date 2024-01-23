//
//  SceneDelegate.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 16.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: LoginController())
//        if let selection = UserDefaults.standard.value(forKey: "userCitySelection") as? String {
//            let mainController = MainController()
//            mainController.viewModel = MainViewModel(requestType: EndPointItems<PrayResponse>.timesForCity(selection), dateManager: DateManager())
//            window.rootViewController = mainController
//            
//        }else if let latitude = UserDefaults.standard.value(forKey: "userLatitude") as? Double,let longitude = UserDefaults.standard.value(forKey: "userLongitude") as? Double  {
//            let mainController = MainController()
//            mainController.viewModel = MainViewModel(requestType: EndPointItems<PrayResponse>.timesForLocation(latitude, longitude), dateManager: DateManager())
//            window.rootViewController = mainController
//        }else {
//            window.rootViewController = navigationController
//        }
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

