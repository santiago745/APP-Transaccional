//
//  IGForgotPasswordRequest.h
//  MobileApp
//
//  Created by steven muñoz on 28/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"
#import "IGPendingActionResponse.h"

@interface IGForgotPasswordRequest : IGBaseModel

@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * birthDate;
@property (nonatomic, copy) NSString * docNumber;
@property (nonatomic, copy) NSString * docType;
@property(nonatomic, copy) IGPendingActionResponse *pendingActionResponse;

@end
