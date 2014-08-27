#import "CraryRestClient.h"
#import "CraryRestClient+Gzip.h"

SpecBegin(CraryRestClientSpecs)

describe(@"default", ^{
    it(@"GET", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        [restClient get:@"echo" parameters:nil complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(0);
            done();
        }];
    });

    it(@"GET with parameters", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient get:@"echo" parameters:parameters complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(1);
            expect(result[@"response"]).to.equal(@"hello");
            done();
        }];
    });

    it(@"POST", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        [restClient post:@"echo" parameters:nil complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(0);
            done();
        }];
    });

    it(@"POST with parameters", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient post:@"echo" parameters:parameters complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(1);
            expect(result[@"response"]).to.equal(@"hello");
            done();
        }];
    });

    it(@"Session", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        NSDictionary *parameters = @{@"data": @"croquis"};
        [restClient post:@"setData" parameters:parameters complete:^(NSError *error, id result) {
            restClient.baseUrl = @"http://localhost:3000/";
            [restClient get:@"getData" parameters:parameters complete:^(NSError *error, id result) {
                expect(result).to.beKindOf([NSDictionary class]);
                expect([result count]).to.equal(1);
                expect(result[@"data"]).to.equal(@"croquis");
                done();
            }];
        }];
    });
    
    it(@"POST with gzipped parameters", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient postGzip:@"echo" parameters:parameters complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(1);
            expect(result[@"response"]).to.equal(@"hello");
            done();
        }];
    });
});

SpecEnd
