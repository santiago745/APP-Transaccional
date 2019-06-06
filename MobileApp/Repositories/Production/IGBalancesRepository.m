//
//  IGBalancesRepository.m
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBalancesRepository.h"
#import "IGError.h"
#import "IGAPIClient.h"
#import "MTLJSONAdapter.h"
#import "IGCompany.h"


@implementation IGBalancesRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getCompanies:(NSString *)docNumber withDocType:(NSString *)docType withBlock:(void (^)(NSArray *response, NSError *))block
{
//    if (![[IGAPIClient sharedInstance] isNetworkAvailable]){
//        if (block) {
//            block(nil, [IGError defaultNoInternetConnectionError]);
//        }
//        return;
//    }
    
    NSDictionary *parameters =  @{ @"docNumber": docNumber,
                                   @"docType": docType,
                                 };
    
    //__weak typeof (self) weakSelf = self;
    
    [[IGAPIClient sharedInstance] GET:@"Contracts" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSArray* responseObject) {
       
        //*operation.securityPolicy.allowInvalidCertificates = YES;
       // *operation.securityPolicy.validatesDomainName = NO;
        
        if (block) {
            NSError *error = nil;
            
            NSArray *companies = [MTLJSONAdapter modelsOfClass:[IGCompany class] fromJSONArray:responseObject error:&error];
        
            block(companies, nil);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
}

@end
