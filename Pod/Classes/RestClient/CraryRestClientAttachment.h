#import <Foundation/Foundation.h>

@interface CraryRestClientAttachment : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSData *data;
@property (strong, nonatomic, readonly) NSString *mimeType;
@property (strong, nonatomic, readonly) NSString *fileName;

- (instancetype)initData:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType fileName:(NSString *)fileName;
+ (CraryRestClientAttachment *)newData:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType fileName:(NSString *)fileName;

@end
