//
//  Field.m
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGField.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation IGField

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"key" : @"Key",
             @"caption" : @"Caption",
             @"value" : @"Value",
             @"dataType" : @"DataType"
            };
}

@end
