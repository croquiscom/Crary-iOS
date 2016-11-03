#import <Foundation/Foundation.h>

@interface CraryRestClientAttachment : NSObject

@property (strong, nonatomic, readonly, nonnull) NSString *name;
@property (strong, nonatomic, readonly, nonnull) NSData *data;
@property (strong, nonatomic, readonly, nonnull) NSString *mimeType;
@property (strong, nonatomic, readonly, nonnull) NSString *fileName;

- (nonnull instancetype)initData:(nonnull NSData *)data name:(nonnull NSString *)name mimeType:(nonnull NSString *)mimeType fileName:(nonnull NSString *)fileName;
+ (nonnull CraryRestClientAttachment *)newData:(nonnull NSData *)data name:(nonnull NSString *)name mimeType:(nonnull NSString *)mimeType fileName:(nonnull NSString *)fileName;

@end
