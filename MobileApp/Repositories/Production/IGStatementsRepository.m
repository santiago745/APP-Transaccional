//
//  IGStatementsRepository.m
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGStatementsRepository.h"
#import "IGError.h"
#import "IGAPIClient.h"
#import "OMPeriod.h"
#import "MTLJSONAdapter.h"


@implementation IGStatementsRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getStatements:(IGStatementsRequest *)request withBlock:(void (^)(NSArray *, NSError *))block
{
    
    NSDictionary *requestJson = [MTLJSONAdapter JSONDictionaryFromModel:request];
    
    [[IGAPIClient sharedInstance] GET:@"statements" parameters:requestJson success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            NSError *error = nil;
            
            NSArray *periods = [MTLJSONAdapter modelsOfClass:[OMPeriod class] fromJSONArray:responseObject error:&error];
            
            block(periods, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];

}

@end
