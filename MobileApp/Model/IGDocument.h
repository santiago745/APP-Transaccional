//
//  IGDocument.h
//  MobileApp
//
//  Created by Rober on 28/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGDocument : IGBaseModel

@property(nonatomic, copy) NSString *caption;
@property(nonatomic, copy) NSString *documentType;

@end
