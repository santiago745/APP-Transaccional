//
//  IGTransactionsHistoryDetailRepository.m
//  MobileApp
//
//  Created by Rober on 27/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTransactionsHistoryDetailRepository.h"
#import "IGError.h"
#import "MTLJSONAdapter.h"
#import "IGAPIClient.h"
#import "IGTransactionDetailResponse.h"


@implementation IGTransactionsHistoryDetailRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getTransactionsHistoryDetail:(NSString *)product withContract:(NSString *)contract withEvent:(NSString *)event withTransaction:(NSString *)transaction docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(IGTransactionDetailResponse *, NSError *))block
{
    
    NSDictionary *parameters =  @{ @"product": product,
                                   @"contract": contract,
                                   @"event": event,
                                   @"docNumber": docNumber,
                                   @"docType": docType,
                                   @"transaction": transaction,
                                   };
    
    [[IGAPIClient sharedInstance] GET:@"transactions" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            
            IGTransactionDetailResponse *response = [MTLJSONAdapter modelOfClass:[IGTransactionDetailResponse class] fromJSONDictionary:responseObject error:nil];
            
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
