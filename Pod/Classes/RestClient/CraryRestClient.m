#import "CraryRestClient.h"
#import "CraryRestClient+Private.h"
#import "AFHTTPRequestOperationManager.h"

@implementation CraryRestClient

+ (CraryRestClient *)sharedClient
{
    static CraryRestClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CraryRestClient alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.baseUrl = @"";
    }
    return self;
}

- (void)setBaseUrl:(NSString *)baseUrl
{
    _baseUrl = baseUrl;
    if (self.requestManager) {
        self.requestManager = nil;
    }
}

- (void)_createRequestManager {
    self.requestManager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestSerializer<AFURLRequestSerialization> *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self.requestManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [self.requestManager setRequestSerializer:requestSerializer];
}

- (void)request:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    if (!self.requestManager) {
        [self _createRequestManager];
    }

    NSMutableURLRequest *request = [self.requestManager.requestSerializer requestWithMethod:method URLString:[NSString stringWithFormat:@"%@%@", self.baseUrl, path] parameters:parameters error:nil];
    AFHTTPRequestOperation *operation = [self.requestManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(complete != nil) {
            complete(nil, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(complete != nil) {
            complete(error, nil);
        }
    }];
    [self.requestManager.operationQueue addOperation:operation];
}

- (void)get:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    [self request:@"GET" path:path parameters:parameters complete:complete];
}

- (void)post:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    [self request:@"POST" path:path parameters:parameters complete:complete];
}

- (void)put:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    [self request:@"PUT" path:path parameters:parameters complete:complete];
}

- (void)delete:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    [self request:@"DELETE" path:path parameters:parameters complete:complete];
}

@end
