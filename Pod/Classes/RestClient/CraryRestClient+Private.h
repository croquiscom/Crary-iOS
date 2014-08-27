#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface CraryRestClient ()

@property (nonatomic, strong) AFHTTPClient *client;
@property (nonatomic, strong) AFHTTPClient *clientGzip;

@end
