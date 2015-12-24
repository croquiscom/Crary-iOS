#import "CraryRestClientAttachment.h"

@interface CraryRestClientAttachment ()

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) NSString *mimeType;
@property (strong, nonatomic) NSString *fileName;

@end

@implementation CraryRestClientAttachment

- (instancetype)initData:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType fileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        self.data = data;
        self.name = name;
        self.mimeType = mimeType;
        self.fileName = fileName;
    }
    return self;
}

+ (CraryRestClientAttachment *)newData:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType fileName:(NSString *)fileName {
    return [[CraryRestClientAttachment alloc] initData:data name:name mimeType:mimeType fileName:fileName];
}

@end
