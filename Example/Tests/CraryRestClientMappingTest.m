#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "CraryRestClient.h"
#import "CraryRestClient+Gzip.h"
#import "CraryRestClientAttachment.h"

#define BASE_URL @"http://localhost:3000/"

@interface CraryRestClientMappingTestPingResult : NSObject
@property (strong, nonatomic) NSString *response;
@end
@implementation CraryRestClientMappingTestPingResult
+ (DCKeyValueObjectMapping *)parser
{
    static DCKeyValueObjectMapping *_parser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _parser = [DCKeyValueObjectMapping mapperForClass:[CraryRestClientMappingTestPingResult class]];
    });
    return _parser;
}
@end

@interface CraryRestClientMappingTestDataResult : NSObject
@property (strong, nonatomic) NSString *data;
@end
@implementation CraryRestClientMappingTestDataResult
+ (DCKeyValueObjectMapping *)parser
{
    static DCKeyValueObjectMapping *_parser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _parser = [DCKeyValueObjectMapping mapperForClass:[CraryRestClientMappingTestDataResult class]];
    });
    return _parser;
}
@end

@interface CraryRestClientMappingTestTestObject : NSObject
@property (strong, nonatomic) NSString *a;
@property (assign, nonatomic) int b;
@property (assign, nonatomic) BOOL c;
@property (strong, nonatomic) CraryRestClientMappingTestTestObject *d;
@end
@implementation CraryRestClientMappingTestTestObject
+ (DCKeyValueObjectMapping *)parser
{
    static DCKeyValueObjectMapping *_parser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _parser = [DCKeyValueObjectMapping mapperForClass:[CraryRestClientMappingTestTestObject class]];
    });
    return _parser;
}
- (id)initA:(NSString *)a b:(int)b c:(BOOL)c d:(CraryRestClientMappingTestTestObject *)d
{
    self = [super init];
    if (self!=nil) {
        self.a = a;
        self.b = b;
        self.c = c;
        self.d = d;
    }
    return self;
}
- (NSDictionary *)toDict
{
    id a = self.a;
    if (a==nil) {
        a = [NSNull null];
    }
    id d = [self.d toDict];
    if (d==nil) {
        d = [NSNull null];
    }
    return @{@"a":a, @"b":@(self.b), @"c":@(self.c), @"d":d};
}
- (void)testA:(NSString *)a b:(int)b c:(BOOL)c d:(CraryRestClientMappingTestTestObject *)d
{
    expect(self.a).to.equal(a);
    expect(self.b).to.equal(b);
    expect(self.c).to.equal(c);
    if (d==nil) {
        expect(self.d).to.beNil;
    } else {
        expect(self.d).notTo.beNil;
        [self.d testA:d.a b:d.b c:d.c d:d.d];
    }
}
@end

@interface CraryRestClientMappingTestUnderlineConvertObject : NSObject
@property (assign, nonatomic) int userId;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *phoneNumber;
@property (assign, nonatomic) int id;
@end
@implementation CraryRestClientMappingTestUnderlineConvertObject
+ (DCKeyValueObjectMapping *)parser
{
    static DCKeyValueObjectMapping *_parser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _parser = [DCKeyValueObjectMapping mapperForClass:[CraryRestClientMappingTestUnderlineConvertObject class]];
    });
    return _parser;
}
@end

@interface CraryRestClientMappingTestPostAttachmentsResultSub : NSObject
@property (strong, nonatomic) NSString *d;
@property (assign, nonatomic) int e;
@end
@implementation CraryRestClientMappingTestPostAttachmentsResultSub
@end

@interface CraryRestClientMappingTestPostAttachmentsResultFile : NSObject
@property (strong, nonatomic) NSString *fileName;
@property (assign, nonatomic) int size;
@property (strong, nonatomic) NSString *type;
@end
@implementation CraryRestClientMappingTestPostAttachmentsResultFile
@end

@interface CraryRestClientMappingTestPostAttachmentsResult : NSObject
@property (strong, nonatomic) NSString *a;
@property (assign, nonatomic) int b;
@property (strong, nonatomic) CraryRestClientMappingTestPostAttachmentsResultSub *c;
@property (strong, nonatomic) CraryRestClientMappingTestPostAttachmentsResultFile *f1;
@property (strong, nonatomic) CraryRestClientMappingTestPostAttachmentsResultFile *f2;
@end
@implementation CraryRestClientMappingTestPostAttachmentsResult
+ (DCKeyValueObjectMapping *)parser
{
    static DCKeyValueObjectMapping *_parser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _parser = [DCKeyValueObjectMapping mapperForClass:[CraryRestClientMappingTestPostAttachmentsResult class]];
    });
    return _parser;
}
@end

SpecBegin(CraryRestClientMappingSpecs)

it(@"GET", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        [restClient get:@"ping" parameters:nil parser:[CraryRestClientMappingTestPingResult parser] complete:^(NSError *error, CraryRestClientMappingTestPingResult *result) {
            expect(error).to.beNil;
            expect(result).notTo.beNil;
            expect(result.response).to.beNil;
            done();
        }];
    });
});

it(@"GET with parameters", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient get:@"ping" parameters:parameters parser:[CraryRestClientMappingTestPingResult parser] complete:^(NSError *error, CraryRestClientMappingTestPingResult *result) {
            expect(error).to.beNil;
            expect(result).notTo.beNil;
            expect(result.response).to.equal(@"hello");
            done();
        }];
    });
});

it(@"POST", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        [restClient post:@"ping" parameters:nil parser:[CraryRestClientMappingTestPingResult parser] complete:^(NSError *error, CraryRestClientMappingTestPingResult *result) {
            expect(error).to.beNil;
            expect(result).notTo.beNil;
            expect(result.response).to.beNil;
            done();
        }];
    });
});

it(@"POST with parameters", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient post:@"ping" parameters:parameters parser:[CraryRestClientMappingTestPingResult parser] complete:^(NSError *error, CraryRestClientMappingTestPingResult *result) {
            expect(error).to.beNil;
            expect(result).notTo.beNil;
            expect(result.response).to.equal(@"hello");
            done();
        }];
    });
});

it(@"Session", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"data": @"croquis"};
        [restClient post:@"setData" parameters:parameters parser:[CraryRestClientMappingTestDataResult parser] complete:^(NSError *error, CraryRestClientMappingTestDataResult *result) {
            restClient.baseUrl = BASE_URL;
            [restClient get:@"getData" parameters:nil parser:[CraryRestClientMappingTestDataResult parser] complete:^(NSError *error, CraryRestClientMappingTestDataResult *result) {
                expect(error).to.beNil;
                expect(result).notTo.beNil;
                expect(result.data).to.equal(@"croquis");
                done();
            }];
        }];
    });
});

it(@"POST with gzipped parameters", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient postGzip:@"ping" parameters:parameters parser:[CraryRestClientMappingTestPingResult parser] complete:^(NSError *error, CraryRestClientMappingTestPingResult *result) {
            expect(error).to.beNil;
            expect(result).notTo.beNil;
            expect(result.response).to.equal(@"hello");
            done();
        }];
    });
});

it(@"Object", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        CraryRestClientMappingTestTestObject *parameters = [[CraryRestClientMappingTestTestObject alloc] initA:@"message" b:5 c:TRUE d:[[CraryRestClientMappingTestTestObject alloc] initA:@"sub" b:0 c:FALSE d:nil]];
        [restClient get:@"echo" parameters:[parameters toDict] parser:[CraryRestClientMappingTestTestObject parser] complete:^(NSError *error, CraryRestClientMappingTestTestObject *result) {
            expect(error).to.beNil;
            expect(result).notTo.beNil;
            [result testA:@"message" b:5 c:TRUE d:[[CraryRestClientMappingTestTestObject alloc] initA:@"sub" b:0 c:FALSE d:nil]];
            [restClient post:@"echo" parameters:[parameters toDict] parser:[CraryRestClientMappingTestTestObject parser] complete:^(NSError *error, CraryRestClientMappingTestTestObject *result) {
                expect(error).to.beNil;
                expect(result).notTo.beNil;
                [result testA:@"message" b:5 c:TRUE d:[[CraryRestClientMappingTestTestObject alloc] initA:@"sub" b:0 c:FALSE d:nil]];
                done();
            }];
        }];
    });
});

it(@"List", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        CraryRestClientMappingTestTestObject *obj1 = [[CraryRestClientMappingTestTestObject alloc] initA:@"obj1" b:11 c:FALSE d:nil];
        CraryRestClientMappingTestTestObject *obj2 = [[CraryRestClientMappingTestTestObject alloc] initA:@"obj2" b:22 c:TRUE d:[[CraryRestClientMappingTestTestObject alloc] initA:@"sub" b:0 c:FALSE d:nil]];
        CraryRestClientMappingTestTestObject *obj3 = [[CraryRestClientMappingTestTestObject alloc] initA:@"obj3" b:33 c:FALSE d:nil];
        NSArray *parameters = @[[obj1 toDict], [obj2 toDict], [obj3 toDict]];
        [restClient post:@"echo" parameters:parameters parser:[CraryRestClientMappingTestTestObject parser] complete:^(NSError *error, NSArray *result) {
            expect(error).to.beNil;
            expect(result).notTo.beNil;
            expect([result count]).to.equal(3);
            [[result objectAtIndex:0] testA:@"obj1" b:11 c:FALSE d:nil];
            [[result objectAtIndex:1] testA:@"obj2" b:22 c:TRUE d:[[CraryRestClientMappingTestTestObject alloc] initA:@"sub" b:0 c:FALSE d:nil]];
            [[result objectAtIndex:2] testA:@"obj3" b:33 c:FALSE d:nil];
            done();
        }];
    });
});

it(@"Underline/id convert", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"user_id":@(123), @"full_name": @"Crary", @"phone_number":@"1-234-5678", @"id":@(456)};
        [restClient get:@"echo" parameters:parameters parser:[CraryRestClientMappingTestUnderlineConvertObject parser] complete:^(NSError *error, CraryRestClientMappingTestUnderlineConvertObject *result) {
            expect(error).to.beNil;
            expect(result).notTo.beNil;
            expect(result.userId).to.equal(123);
            expect(result.fullName).to.equal(@"Crary");
            expect(result.phoneNumber).to.equal(@"1-234-5678");
            expect(result.id).to.equal(456);
            done();
        }];
    });
});

it(@"POST attachments", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"a": @"message", @"b": @(5), @"c": @{@"d": @"hello", @"e": @(9)}};
        unsigned char file1[] = { 1, 2, 3 };
        CraryRestClientAttachment *attachment1 = [CraryRestClientAttachment newData:[NSData dataWithBytes:file1 length:3] name:@"f1" mimeType:@"image/jpeg" fileName:@"photo.jpg"];
        unsigned char file2[] = { 4, 5, 6, 7, 8, 9, 10 };
        CraryRestClientAttachment *attachment2 = [CraryRestClientAttachment newData:[NSData dataWithBytes:file2 length:7] name:@"f2" mimeType:@"audio/mpeg" fileName:@"sound.mp3"];
        NSArray *attachments = @[attachment1, attachment2];
        [restClient post:@"echo" parameters:parameters attachments:attachments parser:[CraryRestClientMappingTestPostAttachmentsResult parser] complete:^(NSError *error, CraryRestClientMappingTestPostAttachmentsResult *result) {
            expect(error).to.beNil;
            expect(result).notTo.beNil;

            expect(result.a).to.equal(@"message");
            expect(result.b).to.equal(5);

            expect(result.c).notTo.beNil;
            expect(result.c.d).to.equal(@"hello");
            expect(result.c.e).to.equal(9);
            
            expect(result.f1).notTo.beNil;
            expect(result.f1.fileName).to.equal(@"photo.jpg");
            expect(result.f1.size).to.equal(3);
            expect(result.f1.type).to.equal(@"image/jpeg");
            
            expect(result.f2).notTo.beNil;
            expect(result.f2.fileName).to.equal(@"sound.mp3");
            expect(result.f2.size).to.equal(7);
            expect(result.f2.type).to.equal(@"audio/mpeg");

            done();
        }];
    });
});

SpecEnd
