//
//  IGGenerateList.h
//  MobileApp
//
//  Created by Rober on 17/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGGenerateList : IGBaseModel

@property (nonatomic) NSInteger reportTypeId;
@property (nonatomic, copy) NSString *reportCode;
@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSArray *fields;

@end
