import Quick
import Nimble

class ObjectConfiguratorSpec: QuickSpec {
    override func spec() {
        describe("ObjectConfigurator") {
            var objectConfigurator: ObjectConfigurator?
            objectConfigurator = ObjectConfigurator()
            it("should configures AppMenuManager correctly.") {
                let menuManager = objectConfigurator?.menuManager()
                expect(menuManager).toNot(beNil())
                expect(menuManager?.menuItemsReader!).toNot(beNil())
                expect(menuManager?.menuItemsBuilder!).toNot(beNil())
                expect(menuManager?.objectConfigurator!).toNot(beNil())
            }
            it("should configure Menu VC correctly.") {
                let menuViewController = objectConfigurator?.menuViewController()
                expect(menuViewController).toNot(beNil())
                expect(menuViewController?.dataSource).toNot(beNil())
                expect(menuViewController?.tapHandlerBuilder).toNot(beNil())
            }
        }
    }
}
