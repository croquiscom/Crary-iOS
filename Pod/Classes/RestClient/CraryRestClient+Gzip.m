#import "CraryRestClient+Gzip.h"
#import "CraryRestClient+Private.h"
#include <zlib.h>

@implementation CraryRestClient (Gzip)

- (void)_createSessionManagerGzip
{
    self.sessionManagerGzip = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer<AFURLRequestSerialization> *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];

    [self.sessionManagerGzip setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [self.sessionManagerGzip setRequestSerializer:requestSerializer];
    
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

- (void)postGzip:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete
{
    if (!self.sessionManagerGzip) {
        [self _createSessionManagerGzip];
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:NULL];
    data = deflateGzip(data);
    
    NSMutableURLRequest *request = [self.sessionManagerGzip.requestSerializer requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@", self.baseUrl, path] parameters:parameters error:nil];
    [request setHTTPBody:data];
    [[self.sessionManagerGzip dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (complete != nil) {
            complete(error, responseObject);
        }
    }] resume];
}

- (void)postGzip:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete
{
    [self postGzip:path parameters:parameters complete:^(NSError *error, id result) {
        if (complete != nil) {
            if (!error) {
                result = [self _parse:result using:parser];
            }
            complete(error, result);
        }
    }];
}

@end
