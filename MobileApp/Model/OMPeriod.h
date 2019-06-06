//
//  OMPeriod.h
//  MobileApp
//
//  Created by Armando Restrepo on 4/21/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface OMPeriod : IGBaseModel

@property(nonatomic, copy) NSString *periodId;
@property(nonatomic, copy) NSString *month;
@property(nonatomic, copy) NSString *year;

@end
