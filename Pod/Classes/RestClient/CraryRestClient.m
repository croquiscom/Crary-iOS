#import "CraryRestClient.h"
#import "CraryRestClient+Private.h"
#import "AFHTTPRequestOperationManager.h"
#import "CraryRestClientAttachment.h"
#import <DCKeyValueObjectMapping/DCKeyValueObjectMapping.h>

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
        self.timeoutInterval = CRARY_TIMEOUT_INTERVAL;
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

- (void)_request:(NSString *)method path:(NSString *)path parameters:(id)parameters attachments:(NSArray<CraryRestClientAttachment *> *)attachments complete:(OnTaskComplete)complete
{
    if (!self.requestManager) {
        [self _createRequestManager];
    }

    NSMutableURLRequest *request;
    NSURL *url = [NSURL URLWithString:path relativeToURL:[NSURL URLWithString:self.baseUrl]];
    if ([attachments count]==0) {
        request = [self.requestManager.requestSerializer requestWithMethod:method URLString:[url absoluteString] parameters:parameters error:nil];
    } else {
        request = [self.requestManager.requestSerializer multipartFormRequestWithMethod:method URLString:[url absoluteString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (CraryRestClientAttachment *attachment in attachments) {
                [formData appendPartWithFileData:attachment.data name:attachment.name fileName:attachment.fileName mimeType:attachment.mimeType];
            }
        } error:nil];
    }
    [request setTimeoutInterval:self.timeoutInterval];

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

- (void)get:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete
{
    [self _request:@"GET" path:path parameters:parameters attachments:nil complete:complete];
}

- (void)post:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete
{
    [self _request:@"POST" path:path parameters:parameters attachments:nil complete:complete];
}

- (void)post:(NSString *)path parameters:(id)parameters attachments:(NSArray<CraryRestClientAttachment *> *)attachments complete:(OnTaskComplete)complete
{
    [self _request:@"POST" path:path parameters:parameters attachments:attachments complete:complete];
}

- (void)put:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete
{
    [self _request:@"PUT" path:path parameters:parameters attachments:nil complete:complete];
}

- (void)put:(NSString *)path parameters:(id)parameters attachments:(NSArray<CraryRestClientAttachment *> *)attachments complete:(OnTaskComplete)complete
{
    [self _request:@"PUT" path:path parameters:parameters attachments:attachments complete:complete];
}

- (void)delete:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete
{
    [self _request:@"DELETE" path:path parameters:parameters attachments:nil complete:complete];
}

- (id)_parse:(id)result using:(DCKeyValueObjectMapping *)parser
{
    if ([result isKindOfClass:[NSDictionary class]]) {
        return [parser parseDictionary:result];
    } else if ([result isKindOfClass:[NSArray class]]) {
        return [parser parseArray:result];
    } else {
        return result;
    }
}

- (void)get:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete
{
    [self get:path parameters:parameters complete:^(NSError *error, id result) {
        if (complete != nil) {
            if (!error) {
                result = [self _parse:result using:parser];
            }
            complete(error, result);
        }
    }];
}

- (void)post:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete
{
    [self post:path parameters:parameters complete:^(NSError *error, id result) {
        if (complete != nil) {
            if (!error) {
                result = [self _parse:result using:parser];
            }
            complete(error, result);
        }
    }];
}

- (void)post:(NSString *)path parameters:(id)parameters attachments:(NSArray<CraryRestClientAttachment *> *)attachments parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete
{
    [self post:path parameters:parameters attachments:attachments complete:^(NSError *error, id result) {
        if (complete != nil) {
            if (!error) {
                result = [self _parse:result using:parser];
            }
            complete(error, result);
        }
    }];
}

- (void)put:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete
{
    [self put:path parameters:parameters complete:^(NSError *error, id result) {
        if (complete != nil) {
            if (!error) {
                result = [self _parse:result using:parser];
            }
            complete(error, result);
        }
    }];
}

- (void)put:(NSString *)path parameters:(id)parameters attachments:(NSArray<CraryRestClientAttachment *> *)attachments parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete
{
    [self put:path parameters:parameters attachments:attachments complete:^(NSError *error, id result) {
        if (complete != nil) {
            if (!error) {
                result = [self _parse:result using:parser];
            }
            complete(error, result);
        }
    }];
}

- (void)delete:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete
{
    [self delete:path parameters:parameters complete:^(NSError *error, id result) {
        if (complete != nil) {
            if (!error) {
                result = [self _parse:result using:parser];
            }
            complete(error, result);
        }
    }];
}

@end
