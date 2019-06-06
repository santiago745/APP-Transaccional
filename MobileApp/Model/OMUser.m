//
//  OMUser.m
//  MobileApp
//
//  Created by Armando Restrepo on 4/24/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMUser.h"

@implementation OMUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"email" : @"Email",
             @"docNumber" : @"DocNumber",
             @"docType" : @"DocType",
             @"name" : @"Name"
             };
}

@end
