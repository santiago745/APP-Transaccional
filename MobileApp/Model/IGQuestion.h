//
//  IGQuestion.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGQuestion : IGBaseModel

@property(nonatomic) NSNumber *questionId;
@property(nonatomic) NSString *text;
@property(nonatomic) NSNumber *type;
@property(nonatomic, copy) NSArray *DefaultAnswers;

@end
