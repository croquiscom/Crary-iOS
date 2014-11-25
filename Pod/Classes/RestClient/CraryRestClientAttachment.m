#import "CraryRestClientAttachment.h"

@interface CraryRestClientAttachment ()

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) NSString *mimeType;
@property (strong, nonatomic) NSString *fileName;

@end

@implementation CraryRestClientAttachment

+ (CraryRestClientAttachment *)newData:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType fileName:(NSString *)fileName
{
    CraryRestClientAttachment *attachment = [[CraryRestClientAttachment alloc] init];
    if (attachment) {
        attachment.data = data;
        attachment.name = name;
        attachment.mimeType = mimeType;
        attachment.fileName = fileName;
    }
    return attachment;
}

@end
