import Crary
import ObjectMapper
import XCTest

class DictionaryTest: XCTestCase {
    func testGetString() {
        let nonil: [String: AnyObject] = ["a": 1, "b": "a", "c": 2.1]
        XCTAssertEqual("", nonil.getString("a"))
        XCTAssertEqual("a", nonil.getString("b"))
        XCTAssertEqual("", nonil.getString("c"))

        let hasnil: [String: AnyObject?] = ["a": 1, "b": "a", "c": nil]
        XCTAssertEqual("", hasnil.getString("a"))
        XCTAssertEqual("a", hasnil.getString("b"))
        XCTAssertEqual("", hasnil.getString("c"))

        let intkey: [Int: AnyObject] = [1: 1, 2: "a", 3: 2.1]
        XCTAssertEqual("", intkey.getString(1))
        XCTAssertEqual("a", intkey.getString(2))
        XCTAssertEqual("", intkey.getString(3))
    }

    func testGetDouble() {
        let dict: [String: AnyObject?] = ["a": 1, "b": "a", "c": 2.1, "d": nil]
        XCTAssertEqual(1, dict.getDouble("a"))
        XCTAssertEqual(0, dict.getDouble("b"))
        XCTAssertEqual(2.1, dict.getDouble("c"))
        XCTAssertEqual(0, dict.getDouble("d"))
    }
}
