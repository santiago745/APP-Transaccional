//
//  IGForgotPasswordResponse.h
//  MobileApp
//
//  Created by steven muñoz on 30/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"
#import "IGPendingActionRequest.h"

@interface IGForgotPasswordResponse : IGBaseModel

@property (nonatomic) NSInteger  status;
@property (nonatomic, copy) NSString * message;
@property(nonatomic, copy) IGPendingActionRequest *pendingActionRequest;

@end
