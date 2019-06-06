//
//  OMUser.h
//  MobileApp
//
//  Created by Armando Restrepo on 4/24/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface OMUser : IGBaseModel

@property (nonatomic, copy) NSString  *email;
@property (nonatomic, copy) NSString  *docNumber;
@property (nonatomic, copy) NSString  *docType;
@property (nonatomic, copy) NSString  *name;
@property (nonatomic, copy) NSString  *token;

@end
