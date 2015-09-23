import Quick
import Nimble

class MenuItemTapHandlerBuilderSpec: QuickSpec {
    override func spec() {
        describe("MenuItemTapHandlerBuilder") {
            var tapHandlerBuilder: MenuItemTapHandlerBuilder?
            var menuItem: MenuItem?
            beforeSuite {
                tapHandlerBuilder = MenuItemTapHandlerBuilder()
                menuItem = MenuItem(title: "Test menu item")
            }
            it("should return Contributions VC for Contribution menu item.") {
                menuItem?.tapHandlerName = "ContributionsViewController"
                let tapHandler = tapHandlerBuilder?.tapHandlerForMenuItem(menuItem)
                expect(tapHandler).to(beAKindOf(ContributionsViewController.classForCoder()))
            }
            it("should return RepositoriesVC for Repositories menu item.") {
                menuItem?.tapHandlerName = "RepositoriesViewController"
                let tapHandler = tapHandlerBuilder?.tapHandlerForMenuItem(menuItem)
                expect(tapHandler).to(beAKindOf(RepositoriesViewController.classForCoder()))
            }
            it("should return PublicActivity VC for PublicActivityViewController menu item.") {
                menuItem?.tapHandlerName = "PublicActivityViewController"
                let tapHandler = tapHandlerBuilder?.tapHandlerForMenuItem(menuItem)
                expect(tapHandler).to(beAKindOf(PublicActivityViewController.classForCoder()))
            }
            it("should return nil for any other menu item.") {
                menuItem?.tapHandlerName = "UnknownViewController"
                let tapHandler = tapHandlerBuilder?.tapHandlerForMenuItem(menuItem)
                expect(tapHandler).to(beNil())
            }
        }
    }
}
