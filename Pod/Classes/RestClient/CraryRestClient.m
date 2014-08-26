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

- (id)init
{
    self = [super init];
    if (self) {
        self.baseUrl = @"";
        [self _createClient];
    }
    return self;
}

- (void)_createClient
{
    NSURL *url = [NSURL URLWithString:self.baseUrl];

    self.client = [[AFHTTPClient alloc] initWithBaseURL:url];
    [self.client setParameterEncoding:AFJSONParameterEncoding];
    [self.client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.client setDefaultHeader:@"Accept" value:@"application/json"];
    
    self.gZipClient = [[AFGzipClient alloc] initWithBaseURL:url];
}

- (void)setBaseUrl:(NSString *)baseUrl
{
    _baseUrl = baseUrl;
    [self _createClient];
}

- (void)GET:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
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

- (void)POST:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
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

- (void)PUT:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
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

- (void)DELETE:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
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

@end
