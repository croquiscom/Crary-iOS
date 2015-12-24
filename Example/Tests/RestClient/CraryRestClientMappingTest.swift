import Crary
import ObjectMapper
import XCTest

let BASE_URL = "http://localhost:3000/"

func toInt(value: AnyObject?) -> Int? {
    if let value = value {
        if let i = value as? Int {
            return i
        } else if let str = value as? String {
            return Int(str)
        }
    }
    return 0
}

func toBool(value: AnyObject?) -> Bool? {
    if let value = value {
        if let i = value as? Bool {
            return i
        } else if let str = value as? String {
            return str == "1"
        }
    }
    return false
}

class CraryRestClientMappingTest: XCTestCase {
    class TestObject: Mappable {
        var a = ""
        var b = 0
        var c = false
        var d: TestObject?

        init(_ a: String, _ b: Int, _ c: Bool, _ d: TestObject?) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
        }

        required init?(_ map: Map) {
        }

        func mapping(map: Map) {
            a <- map["a"]
            b <- (map["b"], TransformOf<Int, AnyObject>(fromJSON: { toInt($0) }, toJSON: { $0 }))
            c <- (map["c"], TransformOf<Bool, AnyObject>(fromJSON: { toBool($0) }, toJSON: { $0 }))
            d <- map["d"]
        }

        func toDict() -> NSDictionary {
            var d: AnyObject = NSNull()
            if self.d != nil {
                d = self.d!.toDict()
            }
            return ["a": self.a, "b": self.b, "c": self.c, "d": d] as NSDictionary
        }

        func test(a: String, _ b: Int, _ c: Bool, _ d: TestObject?) {
            XCTAssertEqual(self.a, a)
            XCTAssertEqual(self.b, b)
            XCTAssertEqual(self.c, c)
            if d == nil {
                XCTAssertNil(self.d)
            } else {
                XCTAssertNotNil(self.d)
                self.d!.test(d!.a, d!.b, d!.c, d!.d)
            }
        }
    }

    class PostAttachmentsResult: Mappable {
        class Sub: Mappable {
            var d: String?
            var e: Int?

            required init?(_ map: Map) {
            }

            func mapping(map: Map) {
                d <- map["d"]
                e <- (map["e"], TransformOf<Int, AnyObject>(fromJSON: { toInt($0) }, toJSON: { $0 }))
            }
        }

        class File: Mappable {
            var fileName: String?
            var size: Int?
            var type: String?

            required init?(_ map: Map) {
            }

            func mapping(map: Map) {
                fileName <- map["file_name"]
                size <- map["size"]
                type <- map["type"]
            }
        }

        var a: String?
        var b: Int?
        var c: Sub?
        var f1: File?
        var f2: File?

        required init?(_ map: Map) {
        }

        func mapping(map: Map) {
            a <- map["a"]
            b <- (map["b"], TransformOf<Int, AnyObject>(fromJSON: { toInt($0) }, toJSON: { $0 }))
            c <- map["c"]
            f1 <- map["f1"]
            f2 <- map["f2"]
        }
    }

    class DateResult : Mappable {
        var d: NSDate?

        required init?(_ map: Map) {
        }

        func mapping(map: Map) {
            d <- (map["d"], CraryDateTransform())
        }
    }

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testObject() {
        let expectation = expectationWithDescription("")

        let restClient = CraryRestClient.sharedClient()
        restClient.baseUrl = BASE_URL
        let parameters = TestObject("message", 5, true, TestObject("sub", 0, false, nil))
        restClient.get("echo", parameters: parameters.toDict()) { (error, result: TestObject?) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            result!.test("message", 5, true, TestObject("sub", 0, false, nil))

            restClient.post("echo", parameters: parameters.toDict(), complete: { (error, result: TestObject?) -> Void in
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                result!.test("message", 5, true, TestObject("sub", 0, false, nil))

                expectation.fulfill()
            })
        }

        waitForExpectationsWithTimeout(10) { (error) -> Void in
        }
    }

    func testList() {
        let expectation = expectationWithDescription("")

        let restClient = CraryRestClient.sharedClient()
        restClient.baseUrl = BASE_URL
        let obj1 = TestObject("obj1", 11, false, nil)
        let obj2 = TestObject("obj2", 22, true, TestObject("sub", 0, false, nil))
        let obj3 = TestObject("obj3", 33, false, nil)
        let parameters = [obj1.toDict(), obj2.toDict(), obj3.toDict()]
        restClient.post("echo", parameters: parameters) { (error, result: [TestObject]?) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            XCTAssertEqual(result!.count, 3)
            result![0].test("obj1", 11, false, nil)
            result![1].test("obj2", 22, true, TestObject("sub", 0, false, nil))
            result![2].test("obj3", 33, false, nil)

            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(10) { (error) -> Void in
        }
    }

    func testPostAttachments() {
        let expectation = expectationWithDescription("")

        let restClient = CraryRestClient.sharedClient()
        restClient.baseUrl = BASE_URL
        let parameters = ["a": "message", "b": 5, "c": ["d": "hello", "e": 9]]
        let file1: [UInt8] = [1, 2, 3]
        let attachment1 = CraryRestClientAttachment(data: NSData(bytes: file1, length: 3), name: "f1", mimeType: "image/jpeg", fileName: "photo.jpg")
        let file2: [UInt8] = [4, 5, 6, 7, 8, 9, 10]
        let attachment2 = CraryRestClientAttachment(data: NSData(bytes: file2, length: 7), name: "f2", mimeType: "audio/mpeg", fileName: "sound.mp3")
        let attachments: [CraryRestClientAttachment] = [attachment1, attachment2]
        restClient.post("echo", parameters: parameters, attachments: attachments) { (error, result: PostAttachmentsResult?) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(result)

            XCTAssertEqual(result!.a, "message")
            XCTAssertEqual(result!.b, 5)

            XCTAssertNotNil(result!.c)
            XCTAssertEqual(result!.c!.d, "hello")
            XCTAssertEqual(result!.c!.e, 9)

            XCTAssertNotNil(result!.f1)
            XCTAssertEqual(result!.f1!.fileName, "photo.jpg")
            XCTAssertEqual(result!.f1!.size, 3)
            XCTAssertEqual(result!.f1!.type, "image/jpeg")

            XCTAssertNotNil(result!.f2)
            XCTAssertEqual(result!.f2!.fileName, "sound.mp3")
            XCTAssertEqual(result!.f2!.size, 7)
            XCTAssertEqual(result!.f2!.type, "audio/mpeg")

            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(10) { (error) -> Void in
        }
    }

    func testDate() {
        let expectation = expectationWithDescription("")

        let restClient = CraryRestClient.sharedClient()
        restClient.baseUrl = BASE_URL
        restClient.post("echo", parameters: ["d": "2014-11-25T10:30:05.010Z"]) { (error, result: DateResult?) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            calendar.timeZone = NSTimeZone(abbreviation: "UTC")!
            let unitFlags: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute, .Second]
            let components = calendar.components(unitFlags, fromDate: result!.d!)
            XCTAssertEqual(components.year, 2014)
            XCTAssertEqual(components.month, 11)
            XCTAssertEqual(components.day, 25)
            XCTAssertEqual(components.hour, 10)
            XCTAssertEqual(components.minute, 30)
            XCTAssertEqual(components.second, 5)
            var time = result!.d!.timeIntervalSince1970 * 1000
            time = time - floor(time/1000)*1000
            XCTAssertEqual(time, 10)

            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(10) { (error) -> Void in
        }
    }
}
