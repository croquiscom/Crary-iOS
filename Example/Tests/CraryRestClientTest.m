#import "CraryRestClient.h"

SpecBegin(CraryRestClientSpecs)

describe(@"basic", ^{
    it(@"GET", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        [CraryRestClient setBaseURL:@"http://localhost:3000/"];
        [restClient getPath:@"echo" parameters:nil complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(0);
            done();
        }];
    });

    it(@"GET with parameters", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        [CraryRestClient setBaseURL:@"http://localhost:3000/"];
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient getPath:@"echo" parameters:parameters complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(1);
            expect(result[@"response"]).to.equal(@"hello");
            done();
        }];
    });

    it(@"POST", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        [CraryRestClient setBaseURL:@"http://localhost:3000/"];
        [restClient postPath:@"echo" parameters:nil complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(0);
            done();
        }];
    });

    it(@"POST with parameters", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        [CraryRestClient setBaseURL:@"http://localhost:3000/"];
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient postPath:@"echo" parameters:parameters complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(1);
            expect(result[@"response"]).to.equal(@"hello");
            done();
        }];
    });

    it(@"Session", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        [CraryRestClient setBaseURL:@"http://localhost:3000/"];
        NSDictionary *parameters = @{@"data": @"croquis"};
        [restClient postPath:@"setData" parameters:parameters complete:^(NSError *error, id result) {
            [restClient getPath:@"getData" parameters:parameters complete:^(NSError *error, id result) {
                expect(result).to.beKindOf([NSDictionary class]);
                expect([result count]).to.equal(1);
                expect(result[@"data"]).to.equal(@"croquis");
                done();
            }];
        }];
    });
});

SpecEnd
