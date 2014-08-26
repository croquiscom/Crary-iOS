#import "CraryRestClient.h"

SpecBegin(CraryRestClientSpecs)

describe(@"basic", ^{
    it(@"GET", ^AsyncBlock{
        CraryRestClient *restClient = [CraryRestClient sharedClient];
        [CraryRestClient setBaseURL:@"https://maps.googleapis.com/maps/api/"];
        NSDictionary *parameters = @{@"latlng": @"37.579617,126.977041"};
        [restClient getPath:@"geocode/json" parameters:parameters complete:^(NSError *error, NSDictionary *result) {
            expect(result).to.beKindOf([NSDictionary class]);
            expect(result[@"status"]).to.equal(@"OK");
            done();
        }];
    });
});

SpecEnd
