//
//  IGAgentsRepository.m
//  MobileApp
//
//  Created by Rober on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGAgentsRepository.h"
#import "IGError.h"
#import "IGAPIClient.h"
#import "MTLJSONAdapter.h"
#import "IGAgent.h"

@implementation IGAgentsRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getAgents:(NSString *)docNumber withDocType:(NSString *)docType withBlock:(void (^)(NSArray *response, NSError *))block
{
    
    NSDictionary *parameters =  @{ @"docNumber": docNumber,
                                   @"docType": docType,
                                   };
    
    [[IGAPIClient sharedInstance] GET:@"agents" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSArray* responseObject) {
        if (block) {
            NSError *error = nil;
            
            NSArray *agents = [MTLJSONAdapter modelsOfClass:[IGAgent class] fromJSONArray:responseObject error:&error];
            
            block(agents, nil);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
}

@end
