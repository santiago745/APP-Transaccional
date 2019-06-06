//
//  IGStatementsRequest.m
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGStatementsRequest.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation IGStatementsRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"docNumber" : @"DocNumber",
             @"docType" : @"DocType",
             @"reportType" : @"ReportType"
            };
}


@end
