//
//  IGPendingActionRequest.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGPendingActionRequest : IGBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger pendingActionType;
@property (nonatomic) NSInteger failAttempts;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSArray  *questions;

@end
