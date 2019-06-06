//
//  IGAPIClient.h
//  salesforce
//
//  Created by Armando Restrepo on 12/29/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "IGError.h"

@interface IGAPIClient : AFHTTPRequestOperationManager

extern NSString * const BASEURL;

+ (IGAPIClient *) sharedInstance;

@property (nonatomic, getter = isNetworkAvailable) BOOL networkAvailable;

@property (nonatomic, copy) IGNetworkAvailabilityBlock networkAvailabilityBlock;

@property (nonatomic, copy) IGInvalidCredentialsBlock invalidCredentialsBlock;

- (IGError *) handleError:(NSError *) error
            withOperation:(AFHTTPRequestOperation *) operation;
-(void)setAuthorizationToken:(NSString *)token;
-(void)clearAuthorizationHeader;

@end
