#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface CraryRestClient ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManagerGzip;

- (id)_parse:(id)result using:(DCKeyValueObjectMapping *)parser;

@end
