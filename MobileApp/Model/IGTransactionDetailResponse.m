//
//  IGTransactionDetailResponse.m
//  MobileApp
//
//  Created by Rober on 24/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTransactionDetailResponse.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGField.h"
#import "IGFund.h"
#import "IGDocument.h"

@implementation IGTransactionDetailResponse


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"fields" : @"Fields",
             @"funds" : @"Funds",
             @"documents" : @"Documents"
             };
}

+ (NSValueTransformer *)fieldsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGField.class];
}

+ (NSValueTransformer *)fundsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGFund.class];
}

+ (NSValueTransformer *)documentsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGDocument.class];
}

@end
