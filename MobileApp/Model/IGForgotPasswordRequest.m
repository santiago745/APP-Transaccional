//
//  IGForgotPasswordRequest.m
//  MobileApp
//
//  Created by steven muñoz on 28/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGForgotPasswordRequest.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import  "IGAnswer.h"

@implementation IGForgotPasswordRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"email" : @"Email",
             @"birthDate" : @"BirthDate",
             @"docNumber" : @"DocNumber",
             @"docType" : @"DocType",
             @"pendingActionResponse" : @"PendingActionResponse"
             };
}

+ (NSValueTransformer *)pendingActionResponseJSONTransformer
{
    // tell Mantle to populate appActions property with an array of ChoosyAppAction objects
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:IGPendingActionResponse.class];
}


@end
