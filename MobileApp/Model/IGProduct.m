//
//  Product.m
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGProduct.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGContract.h"

@implementation IGProduct

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"key" : @"Key",
             @"caption": @"Caption",
             @"totalBalance" : @"TotalBalance",
             @"contracts": @"Contracts"
             };
}


+ (NSValueTransformer *)contractsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGContract.class];
}


@end
