//
//  IGQuestion.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGQuestion.h"
#import "IGAnswer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation IGQuestion


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"questionId" : @"IdQuestion",
             @"text": @"Text",
             @"type" : @"QuestionType",
             @"DefaultAnswers":@"DefaultAnswers"
             };
}


+ (NSValueTransformer *)DefaultAnswersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:IGAnswer.class];
}
@end
