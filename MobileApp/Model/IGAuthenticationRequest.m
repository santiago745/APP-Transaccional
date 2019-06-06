//
//  IGAuthenticationRequest.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGAuthenticationRequest.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation IGAuthenticationRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"login" : @"Login",
             @"password" : @"Password",
             @"deviceNumber" : @"DeviceNumber",
             @"pendingActionResponse" : @"PendingActionResponse"
             };
}

+ (NSValueTransformer *)pendingActionResponseJSONTransformer
{
    // tell Mantle to populate appActions property with an array of ChoosyAppAction objects
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:IGPendingActionResponse.class];
}

@end
