//
//  IGISecutiryRepository.h
//  salesforce
//
//  Created by Armando Restrepo on 3/5/15.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGAuthenticationResponse.h"
#import "IGAuthenticationRequest.h"
#import "IGForgotPasswordRequest.h"
#import "IGForgotPasswordResponse.h"

@protocol IGISecurityRepository<NSObject>

@required

-(void)autoLogin:(void (^)(IGAuthenticationResponse *response, NSError *error))block;

-(void)login:(IGAuthenticationRequest *)request
   withBlock:(void (^)(IGAuthenticationResponse *response, NSError *error))block;

-(void)loginForRestorePass:(IGForgotPasswordRequest *)request
   withBlock:(void (^)(IGForgotPasswordResponse *response, NSError *error))block;

-(void)logout;

@end