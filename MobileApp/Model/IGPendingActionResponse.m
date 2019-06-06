//
//  IGPendingActionResponse.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGPendingActionResponse.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import  "IGAnswer.h"

@implementation IGPendingActionResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"name" : @"Name",
             @"type" : @"PendingActionType",
             @"failedAttempts" : @"FailAttempts",
             @"answers" : @"UserAnswers"
             };
}

+ (NSValueTransformer *)answersJSONTransformer
{
    // tell Mantle to populate appActions property with an array of ChoosyAppAction objects
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGAnswer.class];
}

@end
