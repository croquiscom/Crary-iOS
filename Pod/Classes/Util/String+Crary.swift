import Foundation

extension String {
    func stringByAppendingPathComponent(str: String) -> String {
        return (self as NSString).stringByAppendingPathComponent(str)
    }
}
