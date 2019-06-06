//
//  IGFieldReportRequest.m
//  MobileApp
//
//  Created by Rober on 23/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGFieldReportRequest.h"

@implementation IGFieldReportRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"key" : @"Key",
             @"value" : @"Value"
             };
}

@end
