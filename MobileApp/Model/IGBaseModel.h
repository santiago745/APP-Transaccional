//
//  IGBaseModel.h
//  salesforce
//
//  Created by Armando Restrepo on 11/23/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface IGBaseModel : MTLModel <MTLJSONSerializing>

- (void)updateWithDictionary:(NSDictionary *)dictionary;

@end
