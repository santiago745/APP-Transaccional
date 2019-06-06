//
//  IGFundName.m
//  MobileApp
//
//  Created by Rober on 28/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGFund.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGField.h"

@implementation IGFund

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"fundName" : @"FundName",
             @"fields":@"Fields"
             };
}

+ (NSValueTransformer *)fieldsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGField.class];
}

@end
