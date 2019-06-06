//
//  IGContractDetailRepository.m
//  MobileApp
//
//  Created by Rober on 7/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGContractDetailRepository.h"
#import "IGError.h"
#import "MTLJSONAdapter.h"
#import "IGAPIClient.h"
#import "IGContractDetail.h"

@implementation IGContractDetailRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getContractDetail:(NSString *)docNumber withDocType:(NSString *)docType withProduct:(NSString *)product withPlan:(NSString *)plan withContract:(NSString *)contract withChannel:(NSInteger)channel withBlock:(void (^)(IGContractDetail *, NSError *))block
{
    
    
    NSDictionary *parameters =  @{ @"docNumber": docNumber,
                                   @"docType": docType,
                                   @"plan": plan,
                                   @"product": product,
                                   @"contract": contract,
                                   @"channel": [NSNumber numberWithInteger:channel],
                                   };
    
    [[IGAPIClient sharedInstance] GET:@"Contracts" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            
            IGContractDetail *response = [MTLJSONAdapter modelOfClass:[IGContractDetail class] fromJSONDictionary:responseObject error:nil];
            
            block(response, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
}

@end
