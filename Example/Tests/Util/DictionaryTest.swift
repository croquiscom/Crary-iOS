import Crary
import ObjectMapper
import XCTest

class DictionaryTest: XCTestCase {
    func testGetString() {
        let nonil: [String: AnyObject] = ["a": 1 as AnyObject, "b": "a" as AnyObject, "c": 2.1 as AnyObject]
        XCTAssertEqual("", nonil.getString("a"))
        XCTAssertEqual("a", nonil.getString("b"))
        XCTAssertEqual("", nonil.getString("c"))

        let hasnil: [String: AnyObject?] = ["a": 1 as AnyObject, "b": "a" as AnyObject, "c": nil]
        XCTAssertEqual("", hasnil.getString("a"))
        XCTAssertEqual("a", hasnil.getString("b"))
        XCTAssertEqual("", hasnil.getString("c"))

        let intkey: [Int: AnyObject] = [1: 1 as AnyObject, 2: "a" as AnyObject, 3: 2.1 as AnyObject]
        XCTAssertEqual("", intkey.getString(1))
        XCTAssertEqual("a", intkey.getString(2))
        XCTAssertEqual("", intkey.getString(3))
    }

    func testGetDouble() {
        let dict: [String: AnyObject?] = ["a": 1 as AnyObject, "b": "a" as AnyObject, "c": 2.1 as AnyObject, "d": nil]
        XCTAssertEqual(1, dict.getDouble("a"))
        XCTAssertEqual(0, dict.getDouble("b"))
        XCTAssertEqual(2.1, dict.getDouble("c"))
        XCTAssertEqual(0, dict.getDouble("d"))
    }
}
