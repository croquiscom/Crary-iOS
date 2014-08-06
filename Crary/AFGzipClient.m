#import "AFGzipClient.h"
#import "NSData+Compression.h"

@implementation AFGzipClient
- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self setDefaultHeader:@"Content-Type" value:@"application/json"];
    [self setDefaultHeader:@"Content-Encoding" value:@"gzip"];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"Accept-Encoding" value:@"gzip"];
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    return self;
}

-(void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSData *newData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:NULL];
    newData = [newData  gzipDeflate];
    
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:nil];
    [request setHTTPBody:newData];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}
@end
