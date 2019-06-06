//
//  IGAuthenticationRequest.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"
#import "IGPendingActionResponse.h"

@interface IGAuthenticationRequest : IGBaseModel

@property(nonatomic, copy) NSString *login;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *deviceNumber;
@property(nonatomic, copy) IGPendingActionResponse *pendingActionResponse;

@end
