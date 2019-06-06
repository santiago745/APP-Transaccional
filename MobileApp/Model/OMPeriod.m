//
//  OMPeriod.m
//  MobileApp
//
//  Created by Armando Restrepo on 4/21/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMPeriod.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation OMPeriod


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"periodId" : @"PeriodId",
             @"month" : @"Month",
             @"year" : @"Year"
             };
}

@end
