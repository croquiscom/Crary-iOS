#import <Foundation/Foundation.h>
#import "CraryDefine.h"

@interface CraryRestClient : NSObject

@property (nonatomic, strong) NSString *baseUrl;

+ (CraryRestClient *)sharedClient;

- (void)GET:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)POST:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)PUT:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)DELETE:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)postGzipPath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;

@end
