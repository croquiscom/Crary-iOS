#import "CraryRestClient.h"

SpecBegin(CraryRestClientSpecs)

describe(@"basic", ^{
    it(@"GET", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        [restClient GET:@"echo" parameters:nil complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(0);
            done();
        }];
    });

    it(@"GET with parameters", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient GET:@"echo" parameters:parameters complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(1);
            expect(result[@"response"]).to.equal(@"hello");
            done();
        }];
    });

    it(@"POST", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        [restClient POST:@"echo" parameters:nil complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(0);
            done();
        }];
    });

    it(@"POST with parameters", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = @"http://localhost:3000/";
        NSDictionary *parameters = @{@"message": @"hello"};
        [restClient POST:@"echo" parameters:parameters complete:^(NSError *error, id result) {
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
        [restClient POST:@"setData" parameters:parameters complete:^(NSError *error, id result) {
            restClient.baseUrl = @"http://localhost:3000/";
            [restClient GET:@"getData" parameters:parameters complete:^(NSError *error, id result) {
                expect(result).to.beKindOf([NSDictionary class]);
                expect([result count]).to.equal(1);
                expect(result[@"data"]).to.equal(@"croquis");
                done();
            }];
        }];
    });
});

SpecEnd
