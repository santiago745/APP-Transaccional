//
//  IGAuthenticationResponse.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGAuthenticationResponse.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation IGAuthenticationResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"authenticationStatus" : @"AuthenticationStatus",
             @"authenticationMessage" : @"AuthenticationMessage",
             @"failedAttempts" : @"FailedAttempts",
             @"token" : @"Token",
             @"docNumber" : @"DocNumber",
             @"docType" : @"DocType",
             @"pendingActionRequest" : @"PendingActionRequest",
             @"lastAccess" : @"LastAccess",
             @"user" : @"PersonInfo"
             };
}

+ (NSValueTransformer *)pendingActionRequestJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:IGPendingActionRequest.class];
}

+ (NSValueTransformer *)userJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OMUser.class];
}

@end
