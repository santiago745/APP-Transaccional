//
//  IGTransaction.m
//  MobileApp
//
//  Created by Rober on 24/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTransaction.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "IGField.h"

@implementation IGTransaction


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"productCode" : @"ProductCode",
             @"contract" : @"Contract",
             @"planCode" : @"PlanCode",
             @"eventNumber" : @"EventNumber",
             @"transactionNumber" : @"TransactionNumber",
             @"effectiveDate" : @"EffectiveDate",
             @"netValue" : @"NetValue",
             @"rawValue" : @"RawValue",
             @"descriptionText" : @"Description"
             };
}


@end
