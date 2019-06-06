//
//  Contract.m
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGContract.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGField.h"

@implementation IGContract

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"number" : @"Number",
             @"productCode": @"ProductCode",
             @"planCode" : @"PlanCode",
             @"fields":@"Fields",
             @"WithdrawalsAllowed":@"WithdrawalsAllowed"
             };
}

+ (NSValueTransformer *)fieldsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGField.class];
}

@end
