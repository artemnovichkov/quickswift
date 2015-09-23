import Quick
import Nimble

class FakeAppMenuManager: AppMenuManager {
    override func menuViewController() -> MenuViewController? {
        return MenuViewController()
    }
}

class FakeObjectConfigurator: ObjectConfigurator {
    override func menuManager() -> AppMenuManager {
        return FakeAppMenuManager()
    }
}

class AppDelegateSpec: QuickSpec {
    override func spec() {
        describe("AppDelegate") {
            var window: UIWindow?
            var navigationController: UINavigationController?
            var appDelegate: AppDelegate?
            var didFinishLaunchingWithOptionsReturnValue: Bool?
            
            beforeSuite {
                window = UIWindow()
                navigationController = UINavigationController()
                appDelegate = AppDelegate()
                appDelegate?.window = window
                appDelegate?.navigationController = navigationController
                it ("shouldn't set root VC for window if MenuViewController can't be created.") {
                    class FakeAppMenuManager: AppMenuManager {
                        private override func menuViewController() -> MenuViewController? {
                            return nil
                        }
                    }
                    appDelegate?.objectConfigurator = FakeObjectConfigurator()
                    appDelegate?.application(UIApplication(), didFinishLaunchingWithOptions: nil)
                    expect(window?.rootViewController).to(beNil())
                }
                it ("should set root VC for window if MenuViewController can be created.") {
                    class FakeAppMenuManager: AppMenuManager {
                        private override func menuViewController() -> MenuViewController? {
                            return MenuViewController()
                        }
                    }
                    appDelegate?.objectConfigurator = FakeObjectConfigurator()
                    appDelegate?.application(UIApplication(), didFinishLaunchingWithOptions: nil)
                    expect(window?.rootViewController).to(equal(navigationController))
                }
                it ("should set MenuViewController as RootVC for NavigationController.") {
                    class FakeAppMenuManager: AppMenuManager {
                        private override func menuViewController() -> MenuViewController? {
                            return MenuViewController()
                        }
                    }
                    appDelegate?.objectConfigurator = FakeObjectConfigurator()
                    appDelegate?.application(UIApplication(), didFinishLaunchingWithOptions: nil)
                    let topViewController = appDelegate?.navigationController?.topViewController
                    expect(topViewController).to(beAKindOf(MenuViewController.classForCoder()))
                }
                it ("should window is key after app is launched.") {
                    appDelegate?.application(UIApplication(), didFinishLaunchingWithOptions: nil)
                    expect(window?.keyWindow) == true
                }
                it ("should always returns true with didFinishLaunching method.") {
                    didFinishLaunchingWithOptionsReturnValue = appDelegate?.application(UIApplication(), didFinishLaunchingWithOptions: nil)
                    expect(didFinishLaunchingWithOptionsReturnValue) == true
                }
            }
        }
    }
}
