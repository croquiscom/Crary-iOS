#import "CraryRestClient.h"
#import "CraryRestClient+Private.h"
#import "AFHTTPSessionManager.h"
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
    if (self.sessionManager) {
        self.sessionManager = nil;
    }
}

- (void)_createSessionManager {
    self.sessionManager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer<AFURLRequestSerialization> *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self.sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [self.sessionManager setRequestSerializer:requestSerializer];
}

- (void)_request:(NSString *)method path:(NSString *)path parameters:(id)parameters attachments:(NSArray<CraryRestClientAttachment *> *)attachments complete:(OnTaskComplete)complete
{
    if (!self.sessionManager) {
        [self _createSessionManager];
    }

    NSMutableURLRequest *request;
    NSURL *url = [NSURL URLWithString:path relativeToURL:[NSURL URLWithString:self.baseUrl]];
    if ([attachments count]==0) {
        request = [self.sessionManager.requestSerializer requestWithMethod:method URLString:[url absoluteString] parameters:parameters error:nil];
    } else {
        request = [self.sessionManager.requestSerializer multipartFormRequestWithMethod:method URLString:[url absoluteString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (CraryRestClientAttachment *attachment in attachments) {
                [formData appendPartWithFileData:attachment.data name:attachment.name fileName:attachment.fileName mimeType:attachment.mimeType];
            }
        } error:nil];
    }
    [request setTimeoutInterval:self.timeoutInterval];
    
    [[self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (complete != nil) {
            complete(error, responseObject);
        }
    }] resume];
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
