//
//  IGFieldGenerateList.h
//  MobileApp
//
//  Created by Rober on 17/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGFieldGenerateList : IGBaseModel

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *caption;
@property (nonatomic) NSInteger fieldType;
@property (nonatomic, copy) NSArray *options;

@end
