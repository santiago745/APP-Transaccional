//
//  IGGroup.h
//  MobileApp
//
//  Created by Rober on 8/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGGroup : IGBaseModel

@property(nonatomic,copy) NSString *caption;
@property(nonatomic, copy) NSArray *fields;

@end
