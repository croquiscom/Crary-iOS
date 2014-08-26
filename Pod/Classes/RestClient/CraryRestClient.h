#import <Foundation/Foundation.h>
#import "CraryDefine.h"

@interface CraryRestClient : NSObject

+ (CraryRestClient *)sharedClient;
//TODO : setBaseUrl을 하지 않고 sharedClient를 가져오면 동작하지 않는다. 깔끔하게 처리 할 수 있는 방법은 있는가?
+ (void)setBaseURL:(NSString*)baseURL;

//cookie controll
- (void)saveCookie;
- (void)loadCookie;
- (void)deleteCookie;

//rest api call
- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)postGzipPath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)putPath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)deletePath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters complete:(OnTaskComplete)complete;

@end
