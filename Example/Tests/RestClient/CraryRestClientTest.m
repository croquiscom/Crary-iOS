#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "CraryRestClient.h"
#import "CraryRestClient+Gzip.h"
#import "CraryRestClientAttachment.h"

#define BASE_URL @"http://localhost:3000/"

SpecBegin(CraryRestClient)

it(@"GET", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        [restClient get:@"ping" parameters:nil complete:^(NSError *error, id result) {
            EXP_expect(result).to.beKindOf([NSDictionary class]);
            EXP_expect([result count]).to.equal(0);
            done();
        }];
    });
});

it(@"GET with parameters", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient get:@"ping" parameters:parameters complete:^(NSError *error, id result) {
            EXP_expect(result).to.beKindOf([NSDictionary class]);
            EXP_expect([result count]).to.equal(1);
            EXP_expect(result[@"response"]).to.equal(@"hello");
            done();
        }];
    });
});

it(@"POST", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        [restClient post:@"ping" parameters:nil complete:^(NSError *error, id result) {
            EXP_expect(result).to.beKindOf([NSDictionary class]);
            EXP_expect([result count]).to.equal(0);
            done();
        }];
    });
});

it(@"POST with parameters", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient post:@"ping" parameters:parameters complete:^(NSError *error, id result) {
            EXP_expect(result).to.beKindOf([NSDictionary class]);
            EXP_expect([result count]).to.equal(1);
            EXP_expect(result[@"response"]).to.equal(@"hello");
            done();
        }];
    });
});

it(@"Session", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"data": @"croquis"};
        [restClient post:@"setData" parameters:parameters complete:^(NSError *error, id result) {
            restClient.baseUrl = BASE_URL;
            [restClient get:@"getData" parameters:nil complete:^(NSError *error, id result) {
                EXP_expect(result).to.beKindOf([NSDictionary class]);
                EXP_expect([result count]).to.equal(1);
                EXP_expect(result[@"data"]).to.equal(@"croquis");
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
        [restClient postGzip:@"ping" parameters:parameters complete:^(NSError *error, id result) {
            EXP_expect(result).to.beKindOf([NSDictionary class]);
            EXP_expect([result count]).to.equal(1);
            EXP_expect(result[@"response"]).to.equal(@"hello");
            done();
        }];
    });
});

it(@"List with GET", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL;
        NSDictionary *parameters = @{@"data":@[@"message", @(5), @(TRUE)]};
        [restClient post:@"echo" parameters:parameters complete:^(NSError *error, NSDictionary *result) {
            EXP_expect(error).to.beNil;
            EXP_expect(result).notTo.beNil;
            NSArray *data = result[@"data"];
            EXP_expect(data[0]).to.equal(@"message");
            EXP_expect(data[1]).to.equal(5);
            EXP_expect(data[2]).to.equal(TRUE);
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
        [restClient post:@"echo" parameters:parameters attachments:attachments complete:^(NSError *error, id result) {
            EXP_expect(result).to.beKindOf([NSDictionary class]);

            EXP_expect([result count]).to.equal(5);
            EXP_expect(result[@"a"]).to.equal(@"message");
            EXP_expect([result[@"b"] integerValue]).to.equal(5);

            EXP_expect(result[@"c"][@"d"]).to.equal(@"hello");
            EXP_expect([result[@"c"][@"e"] integerValue]).to.equal(9);

            EXP_expect(result[@"f1"][@"file_name"]).to.equal(@"photo.jpg");
            EXP_expect(result[@"f1"][@"size"]).to.equal(3);
            EXP_expect(result[@"f1"][@"type"]).to.equal(@"image/jpeg");

            EXP_expect(result[@"f2"][@"file_name"]).to.equal(@"sound.mp3");
            EXP_expect(result[@"f2"][@"size"]).to.equal(7);
            EXP_expect(result[@"f2"][@"type"]).to.equal(@"audio/mpeg");

            done();
        }];
    });
});

SpecEnd
