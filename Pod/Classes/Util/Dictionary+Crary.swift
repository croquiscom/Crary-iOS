extension Dictionary {
    public func getString(key: Key) -> String {
        switch self[key] {
        case let value as String:
            return value
        default:
            return ""
        }
    }

    public func getDouble(key: Key) -> Double {
        switch self[key] {
        case let value as Double:
            return value
        default:
            return 0
        }
    }
}
