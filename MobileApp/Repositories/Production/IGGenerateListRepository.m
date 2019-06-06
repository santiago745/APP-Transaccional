//
//  IGGenerateListRepository.m
//  MobileApp
//
//  Created by Rober on 17/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGGenerateListRepository.h"
#import "IGError.h"
#import "MTLJSONAdapter.h"
#import "IGAPIClient.h"
#import "IGGenerateList.h"

@implementation IGGenerateListRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getGenerateList:(NSString *)docNumber withDocType:(NSString *)docType withProduct:(NSString *)product withPlan:(NSString *)plan withContract:(NSString *)contract withBlock:(void (^)(NSArray *, NSError *))block
{
    
    NSDictionary *parameters =  @{ @"docNumber": docNumber,
                                   @"docType": docType,
                                   @"plan": plan,
                                   @"product": product,
                                   @"contract": contract,
                                   };
    
    [[IGAPIClient sharedInstance] GET:@"Statements" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSArray* responseObject) {
        if (block) {
            NSError *error = nil;
            
            NSArray *generateList = [MTLJSONAdapter modelsOfClass:[IGGenerateList class] fromJSONArray:responseObject error:&error];
            
            block(generateList, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
    
}

@end
