//
//  IGContractDetailFields.h
//  MobileApp
//
//  Created by Rober on 7/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGContractDetailGroups : IGBaseModel

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSString *tooltip;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSString *singleValue;
@property (nonatomic, copy) NSArray *listValue;
@property (nonatomic, copy) NSArray *recordValue;

@end
