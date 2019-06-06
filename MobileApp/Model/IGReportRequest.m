//
//  IGReportRequest.m
//  MobileApp
//
//  Created by Rober on 23/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGReportRequest.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation IGReportRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"reportType" : @"ReportType",
             @"reportCode" : @"ReportCode",
             @"docType" : @"DocType",
             @"docNumber" : @"DocNumber",
             @"contract" : @"Contract",
             @"product" : @"Product",
             @"plan" : @"Plan",
             @"fields" : @"Fields"
             };
}

+ (NSValueTransformer *)fieldsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGFieldReportRequest.class];
}

@end