//
//  IGAuthenticationResponse.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"
#import "IGPendingActionRequest.h"
#import "OMUser.h"

@interface IGAuthenticationResponse : IGBaseModel

@property (nonatomic) NSInteger authenticationStatus;
@property (nonatomic, copy) NSString  *authenticationMessage;
@property (nonatomic, copy) NSString  *failedAttempts;
@property (nonatomic, copy) NSString  *token;
@property (nonatomic, copy) NSString  *docNumber;
@property (nonatomic, copy) NSString  *docType;
@property (nonatomic, copy) NSString  *lastAccess;
@property(nonatomic, copy) IGPendingActionRequest *pendingActionRequest;
@property(nonatomic,copy) OMUser *user;

@end
