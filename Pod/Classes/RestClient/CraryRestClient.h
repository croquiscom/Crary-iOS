#import <Foundation/Foundation.h>
#import "CraryDefine.h"

@interface CraryRestClient : NSObject

@property (nonatomic, strong) NSString *baseUrl;

+ (CraryRestClient *)sharedClient;

- (void)get:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)post:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)post:(NSString *)path parameters:(NSDictionary *)parameters attachments:(NSArray *)attachments complete:(OnTaskComplete)complete;
- (void)put:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)put:(NSString *)path parameters:(NSDictionary *)parameters attachments:(NSArray *)attachments complete:(OnTaskComplete)complete;
- (void)delete:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;

@end
