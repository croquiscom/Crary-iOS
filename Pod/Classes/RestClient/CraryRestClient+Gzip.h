#import <Foundation/Foundation.h>
#import "CraryRestClient.h"

@interface CraryRestClient (Gzip)

- (void)postGzip:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;

@end
