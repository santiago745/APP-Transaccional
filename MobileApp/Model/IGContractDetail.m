//
//  IGContractDetail.m
//  MobileApp
//
//  Created by Rober on 7/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGContractDetail.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGGroup.h"

@implementation IGContractDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"number" : @"Number",
             @"productCode": @"ProductCode",
             @"planCode" : @"PlanCode",
             @"groups": @"Groups"
             };
}

+ (NSValueTransformer *)groupsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGGroup.class];
}

@end
