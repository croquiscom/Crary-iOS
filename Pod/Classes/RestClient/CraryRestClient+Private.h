#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface CraryRestClient ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManagerGzip;

- (id)_parse:(id)result using:(DCKeyValueObjectMapping *)parser;

@end
