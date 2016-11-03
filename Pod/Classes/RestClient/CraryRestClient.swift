import ObjectMapper

open class CraryDateTransform: DateFormatterTransform {
    public init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        super.init(dateFormatter: formatter)
    }
}

extension CraryRestClient {
    fileprivate func wrapComplete<T: Mappable>(_ complete: @escaping (NSError?, T?) -> Void) -> OnTaskComplete {
        return { (error, result) -> Void in
            if error != nil {
                complete(error as NSError?, nil)
            } else {
                let converted = Mapper<T>().map(JSONObject: result)
                complete(nil, converted)
            }
        }
    }

    fileprivate func wrapComplete<T: Mappable>(_ complete: @escaping (NSError?, [T]?) -> Void) -> OnTaskComplete {
        return { (error, result) -> Void in
            if error != nil {
                complete(error as NSError?, nil)
            } else {
                let converted = Mapper<T>().mapArray(JSONObject: result)
                complete(nil, converted)
            }
        }
    }

    public func get<T: Mappable>(_ path: String!, parameters: AnyObject?, complete: @escaping (NSError?, T?) -> Void) {
        get(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func get<T: Mappable>(_ path: String!, parameters: AnyObject?, complete: @escaping (NSError?, [T]?) -> Void) {
        get(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func post<T: Mappable>(_ path: String!, parameters: AnyObject?, complete: @escaping (NSError?, T?) -> Void) {
        post(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func post<T: Mappable>(_ path: String!, parameters: AnyObject?, complete: @escaping (NSError?, [T]?) -> Void) {
        post(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func post<T: Mappable>(_ path: String!, parameters: AnyObject?, attachments: [CraryRestClientAttachment]?, complete: @escaping (NSError?, T?) -> Void) {
        post(path, parameters: parameters, attachments: attachments, complete: wrapComplete(complete))
    }

    public func post<T: Mappable>(_ path: String!, parameters: AnyObject?, attachments: [CraryRestClientAttachment]?, complete: @escaping (NSError?, [T]?) -> Void) {
        post(path, parameters: parameters, attachments: attachments, complete: wrapComplete(complete))
    }

    public func put<T: Mappable>(_ path: String!, parameters: AnyObject?, complete: @escaping (NSError?, T?) -> Void) {
        put(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func put<T: Mappable>(_ path: String!, parameters: AnyObject?, complete: @escaping (NSError?, [T]?) -> Void) {
        put(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func put<T: Mappable>(_ path: String!, parameters: AnyObject?, attachments: [CraryRestClientAttachment]?, complete: @escaping (NSError?, T?) -> Void) {
        put(path, parameters: parameters, attachments: attachments, complete: wrapComplete(complete))
    }

    public func put<T: Mappable>(_ path: String!, parameters: AnyObject?, attachments: [CraryRestClientAttachment]?, complete: @escaping (NSError?, [T]?) -> Void) {
        put(path, parameters: parameters, attachments: attachments, complete: wrapComplete(complete))
    }

    public func delete<T: Mappable>(_ path: String!, parameters: AnyObject?, complete: @escaping (NSError?, T?) -> Void) {
        delete(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func delete<T: Mappable>(_ path: String!, parameters: AnyObject?, complete: @escaping (NSError?, [T]?) -> Void) {
        delete(path, parameters: parameters, complete: wrapComplete(complete))
    }
}
