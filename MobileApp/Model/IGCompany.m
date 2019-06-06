//
//  IGCompany.m
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGCompany.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGProduct.h"

@implementation IGCompany

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"key" : @"Key",
             @"caption": @"Caption",
             @"totalBalance" : @"TotalBalance",
             @"products": @"Products"
             };
}

+ (NSValueTransformer *)productsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGProduct.class];
}

@end
