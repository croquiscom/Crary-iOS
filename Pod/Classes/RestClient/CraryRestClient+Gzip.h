#import <Foundation/Foundation.h>
#import "CraryRestClient.h"

@interface CraryRestClient (Gzip)

- (void)postGzip:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete;

- (void)postGzip:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete;

@end
