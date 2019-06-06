//
//  IGForgotPasswordResponse.m
//  MobileApp
//
//  Created by steven muñoz on 30/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGForgotPasswordResponse.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation IGForgotPasswordResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"status" : @"Status",
             @"message" : @"Message",
             @"pendingActionRequest" : @"PendingActionRequest"
             };
}

+ (NSValueTransformer *)pendingActionRequestJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:IGPendingActionRequest.class];
}

@end
