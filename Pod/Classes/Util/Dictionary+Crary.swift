extension Dictionary {
    public func getString(_ key: Key) -> String {
        switch self[key] {
        case let value as String:
            return value
        default:
            return ""
        }
    }

    public func getDouble(_ key: Key) -> Double {
        switch self[key] {
        case let value as Double:
            return value
        case let value as Int:
            return Double(value)
        default:
            return 0
        }
    }
}
