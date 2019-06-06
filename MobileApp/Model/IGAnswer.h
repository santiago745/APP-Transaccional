//
//  IGAnswer.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGAnswer : IGBaseModel

@property(nonatomic) NSNumber *questionId;
@property(nonatomic) NSNumber *answerId;
@property(nonatomic) NSString *text;

@end
