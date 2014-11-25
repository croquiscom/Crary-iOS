#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "CraryRestClient.h"
#import "CraryRestClient+Gzip.h"

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
});

SpecEnd
