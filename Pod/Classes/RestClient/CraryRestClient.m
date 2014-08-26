#import "CraryRestClient.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "AFGzipClient.h"

#define CROQUIS_APP_REST_COOKIE @"croquis_rest_app_cookie"

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

#pragma mark Cookie Controll
- (void) saveCookie
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSData *cookieData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[NSUserDefaults standardUserDefaults] setObject:cookieData forKey:CROQUIS_APP_REST_COOKIE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void) loadCookie
{
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:CROQUIS_APP_REST_COOKIE];
    if([cookiesdata length])
    {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies)
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
}
- (void)deleteCookie
{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSHTTPCookie *cookie;
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
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
