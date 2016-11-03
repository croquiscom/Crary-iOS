#import <Foundation/Foundation.h>
#import "CraryDefine.h"

@class DCKeyValueObjectMapping;
@class CraryRestClientAttachment;

#define CRARY_TIMEOUT_INTERVAL  60  // NSMutableURLRequest.timeoutInterval default value

@interface CraryRestClient : NSObject

@property (nonatomic, strong, nonnull) NSString *baseUrl;
@property NSTimeInterval timeoutInterval;

+ (nonnull CraryRestClient *)sharedClient;

- (void)get:(nonnull NSString *)path parameters:(nullable id)parameters complete:(nullable OnTaskComplete)complete;
- (void)post:(nonnull NSString *)path parameters:(nullable id)parameters complete:(nullable OnTaskComplete)complete;
- (void)post:(nonnull NSString *)path parameters:(nullable id)parameters attachments:(nullable NSArray<CraryRestClientAttachment *> *)attachments complete:(nullable OnTaskComplete)complete;
- (void)put:(nonnull NSString *)path parameters:(nullable id)parameters complete:(nullable OnTaskComplete)complete;
- (void)put:(nonnull NSString *)path parameters:(nullable id)parameters attachments:(nullable NSArray<CraryRestClientAttachment *> *)attachments complete:(nullable OnTaskComplete)complete;
- (void)delete:(nonnull NSString *)path parameters:(nullable id)parameters complete:(nullable OnTaskComplete)complete;

// methods for object mapping
- (void)get:(nonnull NSString *)path parameters:(nullable id)parameters parser:(nullable DCKeyValueObjectMapping *)parser complete:(nullable OnTaskComplete)complete;
- (void)post:(nonnull NSString *)path parameters:(nullable id)parameters parser:(nullable DCKeyValueObjectMapping *)parser complete:(nullable OnTaskComplete)complete;
- (void)post:(nonnull NSString *)path parameters:(nullable id)parameters attachments:(nullable NSArray<CraryRestClientAttachment *> *)attachments parser:(nullable DCKeyValueObjectMapping *)parser complete:(nullable OnTaskComplete)complete;
- (void)put:(nonnull NSString *)path parameters:(nullable id)parameters parser:(nullable DCKeyValueObjectMapping *)parser complete:(nullable OnTaskComplete)complete;
- (void)put:(nonnull NSString *)path parameters:(nullable id)parameters attachments:(nullable NSArray<CraryRestClientAttachment *> *)attachments parser:(nullable DCKeyValueObjectMapping *)parser complete:(nullable OnTaskComplete)complete;
- (void)delete:(nonnull NSString *)path parameters:(nullable id)parameters parser:(nullable DCKeyValueObjectMapping *)parser complete:(nullable OnTaskComplete)complete;

@end
