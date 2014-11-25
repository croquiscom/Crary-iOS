#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "CraryRestClient.h"
#import "CraryRestClient+Gzip.h"
#import "CraryRestClientAttachment.h"

#define BASE_URL @"http://localhost:3000/"

SpecBegin(CraryRestClientSpecs)

describe(@"default", ^{
    it(@"GET", ^{
        waitUntil(^(DoneCallback done) {
            CraryRestClient *restClient = [CraryRestClient sharedClient];
            restClient.baseUrl = BASE_URL;
            [restClient get:@"ping" parameters:nil complete:^(NSError *error, id result) {
                expect(result).to.beKindOf([NSDictionary class]);
                expect([result count]).to.equal(0);
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
                expect(result).to.beKindOf([NSDictionary class]);
                expect([result count]).to.equal(1);
                expect(result[@"response"]).to.equal(@"hello");
                done();
            }];
        });
    });

    it(@"POST", ^{
        waitUntil(^(DoneCallback done) {
            CraryRestClient *restClient = [CraryRestClient sharedClient];
            restClient.baseUrl = BASE_URL;
            [restClient post:@"ping" parameters:nil complete:^(NSError *error, id result) {
                expect(result).to.beKindOf([NSDictionary class]);
                expect([result count]).to.equal(0);
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
                expect(result).to.beKindOf([NSDictionary class]);
                expect([result count]).to.equal(1);
                expect(result[@"response"]).to.equal(@"hello");
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
                    expect(result).to.beKindOf([NSDictionary class]);
                    expect([result count]).to.equal(1);
                    expect(result[@"data"]).to.equal(@"croquis");
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
                expect(result).to.beKindOf([NSDictionary class]);
                expect([result count]).to.equal(1);
                expect(result[@"response"]).to.equal(@"hello");
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
                expect(result).to.beKindOf([NSDictionary class]);

                expect([result count]).to.equal(5);
                expect(result[@"a"]).to.equal(@"message");
                expect([result[@"b"] integerValue]).to.equal(5);

                expect(result[@"c"][@"d"]).to.equal(@"hello");
                expect([result[@"c"][@"e"] integerValue]).to.equal(9);

                expect(result[@"f1"][@"file_name"]).to.equal(@"photo.jpg");
                expect(result[@"f1"][@"size"]).to.equal(3);
                expect(result[@"f1"][@"type"]).to.equal(@"image/jpeg");

                expect(result[@"f2"][@"file_name"]).to.equal(@"sound.mp3");
                expect(result[@"f2"][@"size"]).to.equal(7);
                expect(result[@"f2"][@"type"]).to.equal(@"audio/mpeg");

                done();
            }];
        });
    });
});

SpecEnd
