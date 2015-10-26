#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "CraryRestClient.h"

#define BASE_URL @"http://localhost:3000/"

SpecBegin(CraryRestClientResolve)

it(@"parent", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL @"sub/";
        [restClient get:@"../ping" parameters:nil complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(0);
            done();
        }];
    });
});

it(@"absolute", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL @"sub/";
        [restClient get:@"/ping" parameters:nil complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(0);
            done();
        }];
    });
});

it(@"full", ^{
    waitUntil(^(DoneCallback done) {
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        restClient.baseUrl = BASE_URL @"sub/";
        [restClient get:BASE_URL @"ping" parameters:nil complete:^(NSError *error, id result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect([result count]).to.equal(0);
            done();
        }];
    });
});

SpecEnd
