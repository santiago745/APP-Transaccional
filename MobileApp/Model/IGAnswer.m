//
//  IGAnswer.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGAnswer.h"

@implementation IGAnswer

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"questionId" : @"QuestionId",
             @"answerId" : @"AnswerId",
             @"text" : @"Text"
             };
}

@end
