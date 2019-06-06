//
//  IGAgent.h
//  MobileApp
//
//  Created by Rober on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGAgent : IGBaseModel

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *cellPhone;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *agencyName;
@property(nonatomic, copy) NSString *agencyAddress;
@property(nonatomic, copy) NSString *photo;

@end
