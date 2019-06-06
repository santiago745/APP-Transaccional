//
//  IGGroup.m
//  MobileApp
//
//  Created by Rober on 8/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGGroup.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGContractDetailGroups.h"

@implementation IGGroup

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"caption" : @"Caption",
             @"fields":@"Fields"
             };
}

+ (NSValueTransformer *)fieldsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGContractDetailGroups.class];
}

@end
