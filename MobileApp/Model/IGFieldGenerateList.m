//
//  IGFieldGenerateList.m
//  MobileApp
//
//  Created by Rober on 17/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGFieldGenerateList.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGOption.h"

@implementation IGFieldGenerateList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"key" : @"key",
             @"caption": @"caption",
             @"fieldType" : @"FieldType",
             @"options":@"options"
             };
}

+ (NSValueTransformer *)optionsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGOption.class];
}

@end
