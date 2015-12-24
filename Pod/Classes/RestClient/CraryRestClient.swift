import ObjectMapper

public class CraryDateTransform: DateFormatterTransform {
    public init() {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        super.init(dateFormatter: formatter)
    }
}

extension CraryRestClient {
    private func wrapComplete<T: Mappable>(complete: (NSError?, T?) -> Void) -> OnTaskComplete {
        return { (error, result) -> Void in
            if error != nil {
                complete(error, nil)
            } else {
                let converted = Mapper<T>().map(result)
                complete(nil, converted)
            }
        }
    }

    private func wrapComplete<T: Mappable>(complete: (NSError?, [T]?) -> Void) -> OnTaskComplete {
        return { (error, result) -> Void in
            if error != nil {
                complete(error, nil)
            } else {
                let converted = Mapper<T>().mapArray(result)
                complete(nil, converted)
            }
        }
    }

    public func get<T: Mappable>(path: String!, parameters: AnyObject?, complete: (NSError?, T?) -> Void) {
        get(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func get<T: Mappable>(path: String!, parameters: AnyObject?, complete: (NSError?, [T]?) -> Void) {
        get(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func post<T: Mappable>(path: String!, parameters: AnyObject?, complete: (NSError?, T?) -> Void) {
        post(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func post<T: Mappable>(path: String!, parameters: AnyObject?, complete: (NSError?, [T]?) -> Void) {
        post(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func post<T: Mappable>(path: String!, parameters: AnyObject?, attachments: [CraryRestClientAttachment]?, complete: (NSError?, T?) -> Void) {
        post(path, parameters: parameters, attachments: attachments, complete: wrapComplete(complete))
    }

    public func post<T: Mappable>(path: String!, parameters: AnyObject?, attachments: [CraryRestClientAttachment]?, complete: (NSError?, [T]?) -> Void) {
        post(path, parameters: parameters, attachments: attachments, complete: wrapComplete(complete))
    }

    public func put<T: Mappable>(path: String!, parameters: AnyObject?, complete: (NSError?, T?) -> Void) {
        put(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func put<T: Mappable>(path: String!, parameters: AnyObject?, complete: (NSError?, [T]?) -> Void) {
        put(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func put<T: Mappable>(path: String!, parameters: AnyObject?, attachments: [CraryRestClientAttachment]?, complete: (NSError?, T?) -> Void) {
        put(path, parameters: parameters, attachments: attachments, complete: wrapComplete(complete))
    }

    public func put<T: Mappable>(path: String!, parameters: AnyObject?, attachments: [CraryRestClientAttachment]?, complete: (NSError?, [T]?) -> Void) {
        put(path, parameters: parameters, attachments: attachments, complete: wrapComplete(complete))
    }

    public func delete<T: Mappable>(path: String!, parameters: AnyObject?, complete: (NSError?, T?) -> Void) {
        delete(path, parameters: parameters, complete: wrapComplete(complete))
    }

    public func delete<T: Mappable>(path: String!, parameters: AnyObject?, complete: (NSError?, [T]?) -> Void) {
        delete(path, parameters: parameters, complete: wrapComplete(complete))
    }
}
