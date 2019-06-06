//
//  IGPendingActionResponse.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGPendingActionResponse : IGBaseModel

@property(nonatomic, copy) NSString *name;
@property(nonatomic) NSInteger type;
@property(nonatomic) NSInteger failedAttempts;
@property(nonatomic, copy) NSArray *answers;


@end
