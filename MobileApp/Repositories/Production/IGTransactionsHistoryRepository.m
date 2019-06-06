//
//  IGTransactionsHistoryRepository.m
//  MobileApp
//
//  Created by Rober on 24/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTransactionsHistoryRepository.h"
#import "IGError.h"
#import "MTLJSONAdapter.h"
#import "IGAPIClient.h"
#import "IGTransaction.h"


@implementation IGTransactionsHistoryRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}



-(void)getTransactionsHistory:(NSString *)product withContract:(NSString *)contract withPlan:(NSString *)plan withSet:(NSInteger)set docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(NSArray *response, NSError *error))block
{
    
    NSDictionary *parameters =  @{ @"product": product,
                                   @"contract": contract,
                                   @"plan": plan,
                                   @"docNumber": docNumber,
                                   @"docType": docType,
                                   @"set": [NSNumber numberWithInteger:set],
                                   };
    
    [[IGAPIClient sharedInstance] GET:@"transactions" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        if (block) {
            
            NSError *error = nil;
            
            NSArray *transactions = [MTLJSONAdapter modelsOfClass:[IGTransaction class] fromJSONArray:responseObject error:&error];
            
            block(transactions, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
}

@end
