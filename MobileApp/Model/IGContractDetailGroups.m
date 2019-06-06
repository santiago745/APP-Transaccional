//
//  IGContractDetailFields.m
//  MobileApp
//
//  Created by Rober on 7/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGContractDetailGroups.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "MTLValueTransformer.h"
#import "IGRecordValue.h"

@implementation IGContractDetailGroups

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"key" : @"Key",
             @"caption": @"Caption",
             @"tooltip" : @"Tooltip",
             @"type" : @"Type",
             @"singleValue": @"SingleValue",
             @"listValue" : @"ListValue",
             @"recordValue": @"RecordValue"
             };
}

+ (NSValueTransformer *)recordValueJSONTransformer {
//    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGRecordValue.class];
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSArray *array) {
        NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:array.count];
        for (NSArray *arrayObject in array) {
            NSMutableArray *values2 = [[NSMutableArray alloc] initWithCapacity:arrayObject.count];
            for (IGRecordValue *property in arrayObject) {
                [values2 addObject:property];
            }
            [values addObject:values2];
        }
        return values;
    }];
}


@end
