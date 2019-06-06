//
//  IGAgent.m
//  MobileApp
//
//  Created by Rober on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGAgent.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation IGAgent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"Name",
             @"email" : @"Email",
             @"cellPhone" : @"CellPhone",
             @"phone" : @"Phone",
             @"agencyName" : @"AgencyName",
             @"agencyAddress" : @"AgencyAddress",
             @"photo" : @"Photo"
             };
}

@end
