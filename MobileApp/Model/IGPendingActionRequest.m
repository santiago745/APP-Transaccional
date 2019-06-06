//
//  IGPendingActionRequest.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGPendingActionRequest.h"
#import "IGQuestion.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation IGPendingActionRequest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"name" : @"Name",
             @"pendingActionType" : @"PendingActionType",
             @"failAttempts" : @"FailAttempts",
             @"message" : @"Message",
             @"questions" : @"Questions"
             };
}

+ (NSValueTransformer *)questionsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGQuestion.class];
}
@end
