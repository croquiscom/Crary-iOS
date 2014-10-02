#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface CraryRestClient ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManagerGzip;

@end
