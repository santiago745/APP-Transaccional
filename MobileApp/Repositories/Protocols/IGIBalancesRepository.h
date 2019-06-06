//
//  IGIBalancesRepository.h
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IGIBalancesRepository<NSObject>

@required

-(void) getCompanies:(NSString *)docNumber
        withDocType:(NSString *)docType
        withBlock:(void (^)(NSArray *response, NSError *error))block;

@end
