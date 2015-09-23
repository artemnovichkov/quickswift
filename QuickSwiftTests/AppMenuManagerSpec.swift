import Quick
import Nimble

class AppMenuManagerSpec: QuickSpec {
    override func spec() {
        describe("AppMenuManager") {
            var menuManager: AppMenuManager?
            var fakeMenuItemsReader: FakeMenuItemsReader?
            var fakeMenuItemsBuilder: FakeMenuItemsBuilder?
            var menuViewController: MenuViewController?
            beforeSuite {
                menuManager = AppMenuManager()
                fakeMenuItemsReader = FakeMenuItemsReader()
                fakeMenuItemsBuilder = FakeMenuItemsBuilder()
                menuManager?.menuItemsReader = fakeMenuItemsReader
                menuManager?.menuItemsBuilder = fakeMenuItemsBuilder
            }
            it ("shouldn't create menu view controller with metadata error.") {
                fakeMenuItemsReader?.errorToReturn = self.fakeError()
                menuViewController = menuManager?.menuViewController()
                expect(menuViewController).to(beNil())
            }
            it("should contain equal items.") {
                menuViewController = menuManager?.menuViewController()
                fakeMenuItemsReader?.errorToReturn = nil
                let (metadataReturnedByReader, _) = fakeMenuItemsReader!.readMenuItems()
                fakeMenuItemsBuilder?.buildMenuItemsFromMetadata(metadataReturnedByReader!)
                let metadataReceivedByBuilder = fakeMenuItemsBuilder!.metadata
                expect(metadataReturnedByReader?.count) == metadataReceivedByBuilder?.count
            }
            it("should returns nil if menu items could not be built.") {
                fakeMenuItemsBuilder?.errorToReturn = self.fakeError()
                menuViewController = menuManager?.menuViewController()
                expect(menuViewController).to(beNil())
            }
//            it ("should create menuViewController if menu items available.") {
//                fakeMenuItemsBuilder?.menuItemsToReturn = self.fakeMenuItems()
//                menuViewController = menuManager?.menuViewController()
//                expect(menuViewController).toNot(beNil())
//                expect(menuViewController?.dataSource).toNot(beNil())
//            }
        }
    }
    func fakeError() -> NSError {
        let errorMessage = "Fake error description"
        let userInfo = [NSLocalizedDescriptionKey: errorMessage]
        return NSError(domain:"Fake Error domain", code: 0, userInfo: userInfo)
    }
    func fakeMenuItems() -> [MenuItem] {
        let menuItem = MenuItem(title: "Fake menu item")
        return [menuItem]
    }
}
