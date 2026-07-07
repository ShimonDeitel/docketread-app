import XCTest
@testable import DocketRead-MangaLog

@MainActor
final class DocketRead-MangaLogTests: XCTestCase {
    var store: Store!

    override func setUp() {
        super.setUp()
        store = Store()
    }

    func testSeedDataLoadedOnFreshInstall() {
        XCTAssertFalse(store.items.isEmpty)
    }

    func testSeedCountIsBelowFreeLimit() {
        XCTAssertLessThan(store.items.count, Store.freeLimit)
    }

    func testAddIncreasesCount() {
        let before = store.items.count
        store.add(Series())
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testCanAddWhenBelowLimit() {
        XCTAssertTrue(store.canAdd(isPro: false))
    }

    func testCannotAddPastFreeLimitWhenNotPro() {
        for _ in 0..<(Store.freeLimit + 5) {
            store.add(Series())
        }
        XCTAssertFalse(store.canAdd(isPro: false))
    }

    func testCanAlwaysAddWhenPro() {
        for _ in 0..<(Store.freeLimit + 5) {
            store.add(Series())
        }
        XCTAssertTrue(store.canAdd(isPro: true))
    }

    func testDeleteRemovesItem() {
        let item = Series()
        store.add(item)
        store.delete(item)
        XCTAssertFalse(store.items.contains(where: { $0.id == item.id }))
    }

    func testIsAtFreeLimitReflectsCount() {
        while store.items.count < Store.freeLimit {
            store.add(Series())
        }
        XCTAssertTrue(store.isAtFreeLimit)
    }
}
