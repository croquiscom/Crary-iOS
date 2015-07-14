#import <Foundation/Foundation.h>
#import "CraryDefine.h"

@class DCKeyValueObjectMapping;

#define CRARY_TIMEOUT_INTERVAL  60  // NSMutableURLRequest.timeoutInterval default value

@interface CraryRestClient : NSObject

@property (nonatomic, strong) NSString *baseUrl;
@property NSTimeInterval timeoutInterval;

+ (CraryRestClient *)sharedClient;

- (void)get:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete;
- (void)post:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete;
- (void)post:(NSString *)path parameters:(id)parameters attachments:(NSArray *)attachments complete:(OnTaskComplete)complete;
- (void)put:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete;
- (void)put:(NSString *)path parameters:(id)parameters attachments:(NSArray *)attachments complete:(OnTaskComplete)complete;
- (void)delete:(NSString *)path parameters:(id)parameters complete:(OnTaskComplete)complete;

// methods for object mapping
- (void)get:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete;
- (void)post:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete;
- (void)post:(NSString *)path parameters:(id)parameters attachments:(NSArray *)attachments parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete;
- (void)put:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete;
- (void)put:(NSString *)path parameters:(id)parameters attachments:(NSArray *)attachments parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete;
- (void)delete:(NSString *)path parameters:(id)parameters parser:(DCKeyValueObjectMapping *)parser complete:(OnTaskComplete)complete;

@end
