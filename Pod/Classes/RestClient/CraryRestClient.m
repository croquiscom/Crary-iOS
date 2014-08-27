#import "CraryRestClient.h"
#import "CraryRestClient+Private.h"
#import "AFJSONRequestOperation.h"

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

- (void)_createClient
{
    self.client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
    [self.client setParameterEncoding:AFJSONParameterEncoding];
    [self.client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.client setDefaultHeader:@"Accept" value:@"application/json"];
    [self.client setDefaultHeader:@"Content-Type" value:@"application/json"];
}

- (void)setBaseUrl:(NSString *)baseUrl
{
    _baseUrl = baseUrl;
    if (self.client) {
        self.client = nil;
    }
}

- (void)request:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    if (!self.client) {
        [self _createClient];
    }
	NSURLRequest *request = [self.client requestWithMethod:method path:path parameters:parameters];
    AFHTTPRequestOperation *operation = [self.client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(complete != nil) {
            complete(nil, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(complete != nil) {
            complete(error, nil);
        }
    }];
    [self.client enqueueHTTPRequestOperation:operation];
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
