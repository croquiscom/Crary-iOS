#import "CraryRestClient+Gzip.h"
#import "CraryRestClient+Private.h"
#import "AFJSONRequestOperation.h"
#include <zlib.h>

@implementation CraryRestClient (Gzip)

- (void)_createClientGzip
{
    self.clientGzip = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:self.baseUrl]];
    [self.clientGzip setParameterEncoding:AFJSONParameterEncoding];
    [self.clientGzip registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.clientGzip setDefaultHeader:@"Accept" value:@"application/json"];
    [self.clientGzip setDefaultHeader:@"Content-Type" value:@"application/json"];
    [self.clientGzip setDefaultHeader:@"Content-Encoding" value:@"gzip"];
}

static NSData *deflateGzip(NSData *data)
{
    if ([data length] == 0) {
        return data;
    }

    z_stream strm;

    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[data bytes];
    strm.avail_in = (uInt)[data length];

    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) {
        return nil;
    }

    NSMutableData *compressed = [NSMutableData dataWithLength:16384];

    do {
        if (strm.total_out >= [compressed length]) {
            [compressed increaseLengthBy: 16384];
        }
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        deflate(&strm, Z_FINISH);
    } while (strm.avail_out == 0);

    deflateEnd(&strm);

    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}

- (void)postGzip:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete
{
    if (!self.clientGzip) {
        [self _createClientGzip];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:NULL];
    data = deflateGzip(data);
    
    NSMutableURLRequest *request = [self.clientGzip requestWithMethod:@"POST" path:path parameters:nil];
    [request setHTTPBody:data];

    AFHTTPRequestOperation *operation = [self.clientGzip HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(complete != nil) {
            complete(nil, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(complete != nil) {
            complete(error, nil);
        }
    }];
    [self.clientGzip enqueueHTTPRequestOperation:operation];
}

@end
