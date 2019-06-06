//
//  IGTableValue.h
//  MobileApp
//
//  Created by Rober on 7/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGRecordValue : IGBaseModel

@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSString *value;

@end
