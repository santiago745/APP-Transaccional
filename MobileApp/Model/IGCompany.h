//
//  IGCompany.h
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGCompany : IGBaseModel

@property(nonatomic, copy) NSString *key;
@property(nonatomic, copy) NSString *caption;
@property(nonatomic, copy) NSString *totalBalance;
@property(nonatomic, copy) NSArray *products;

@end
