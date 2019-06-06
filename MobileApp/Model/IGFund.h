//
//  IGFundName.h
//  MobileApp
//
//  Created by Rober on 28/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGFund : IGBaseModel

@property(nonatomic, copy) NSString *fundName;
@property(nonatomic, copy) NSArray *fields;

@end
