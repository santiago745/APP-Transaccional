//
//  IGAPIClient.m
//  salesforce
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "IGAPIClient.h"
#import "IGMobileApp.h"

//Url desarrollo
static NSString * const IGAPIBaseURLString = @"https://staging.mobile.oldmutual.com.co/OM.MobileApi.Public/Api";

//Url produccion
//static NSString * const IGAPIBaseURLString = @"https://www.skandia.com.co/OM.MobileApi.Public/Api";

//Url produccion nueva
//static NSString * const IGAPIBaseURLString = @"https://mobile.oldmutual.com.co/OM.MobileApi.Public/Api";

//Url produccion nueva
//static NSString * const IGAPIBaseURLString = @"https://mobile.oldmutual.com.co/OM.MobileApi.Public_v2.0/Api";


@implementation IGAPIClient
static id _sharedInstance;

+ (IGAPIClient *) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString * const BASEURL = IGAPIBaseURLString;
        _sharedInstance = [[IGAPIClient alloc] initWithBaseURL:[NSURL URLWithString:IGAPIBaseURLString]];
        
    });
    
    
    return _sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (!self) {
        return nil;
    }
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.securityPolicy.allowInvalidCertificates=YES;
    self.securityPolicy.validatesDomainName=NO;
    return self;
}

- (IGError *) handleError:(NSError *) error
            withOperation:(AFHTTPRequestOperation *) operation {
    
    IGError *igError = [IGError IGErrorFromAFNetworkingError:error withOperation:operation];
    
    if (igError && (igError.code == IGErrorInvalidCredentialService || igError.code == IGErrorNoCredential )) {
        if (self.invalidCredentialsBlock) {
            self.invalidCredentialsBlock(igError);
        }
    } else if (igError && (igError.code == IGErrorNoInternetConnection)) {
        if (self.networkAvailabilityBlock) {
            self.networkAvailabilityBlock(NO);
        }
    }
    
    return igError;
    
}

-(void)setAuthorizationToken:(NSString *)token
{
    [self.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
}

-(void)clearAuthorizationHeader
{
    [self.requestSerializer setValue:IGEmptyString forHTTPHeaderField:@"Authorization"];
}

- (BOOL) isNetworkAvailable {
    
    NSURL *urlToCheck = [NSURL URLWithString:GOOGLE_URL];
    NSData *checkNetworkAvailability = [NSData dataWithContentsOfURL:urlToCheck];
  
    return checkNetworkAvailability != nil;
};

@end
