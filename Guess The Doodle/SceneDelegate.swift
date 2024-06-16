import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let signInView = SignInView()

        window.rootViewController = UIHostingController(rootView: signInView)
        self.window = window
        window.makeKeyAndVisible()
    }

    // Diğer scene yaşam döngüsü metotları...

    func sceneDidDisconnect(_ scene: UIScene) { /* Kodlar... */ }
    func sceneDidBecomeActive(_ scene: UIScene) { /* Kodlar... */ }
    func sceneWillResignActive(_ scene: UIScene) { /* Kodlar... */ }
    func sceneWillEnterForeground(_ scene: UIScene) { /* Kodlar... */ }
    func sceneDidEnterBackground(_ scene: UIScene) { /* Kodlar... */ }
}
