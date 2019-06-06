//
//  IGGenerateList.m
//  MobileApp
//
//  Created by Rober on 17/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGGenerateList.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGFieldGenerateList.h"

@implementation IGGenerateList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"reportTypeId" : @"reportTypeId",
             @"reportCode": @"reportCode",
             @"caption" : @"caption",
             @"fields":@"fields"
             };
}

+ (NSValueTransformer *)fieldsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGFieldGenerateList.class];
}

@end
