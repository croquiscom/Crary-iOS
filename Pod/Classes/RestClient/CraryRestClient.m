#import "CraryRestClient.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "AFGzipClient.h"

@interface CraryRestClient ()
@property (nonatomic, strong) AFHTTPClient *client;
@property (nonatomic, strong) AFGzipClient *gZipClient;
@end

@implementation CraryRestClient

#pragma mark - Initialize
+ (CraryRestClient *)sharedClient
{
    static CraryRestClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CraryRestClient alloc] init];
    });
    
    return _sharedClient;
}

+ (void)setBaseURL:(NSString *)baseURL
{
    [[CraryRestClient sharedClient] createClientWithURL:[NSURL URLWithString:baseURL]];
}

- (void)createClientWithURL:(NSURL*)url
{
    self.client = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    [self.client setParameterEncoding:AFJSONParameterEncoding];
    [self.client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
    [self.client setDefaultHeader:@"Accept" value:@"application/json"];
    //[self.client setDefaultHeader:@"Accept-Encoding" value:@"gzip"];
    
    self.gZipClient = [[AFGzipClient alloc] initWithBaseURL:url];
}

#pragma mark Rest API Call
- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    [self.client postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id result) {
        if(complete != nil)
        {
            complete(nil, result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(complete != nil)
        {
            complete(error, nil);
        }
    }];
}
- (void)postGzipPath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    [self.gZipClient postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id result) {
        if(complete != nil)
        {
            complete(nil, result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(complete != nil)
        {
            complete(error, nil);
        }
    }];
}
- (void)putPath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    [self.client putPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id result) {
        if(complete != nil)
        {
            complete(nil, result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(complete != nil)
        {
            complete(error, nil);
        }
    }];
}
- (void)deletePath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    [self.client deletePath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id result) {
        if(complete != nil)
        {
            complete(nil, result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(complete != nil)
        {
            complete(error, nil);
        }
    }];
}
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    [self.client getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id result) {
        if(complete != nil)
        {
            complete(nil, result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(complete != nil)
        {
            complete(error, nil);
        }
    }];
}

@end
