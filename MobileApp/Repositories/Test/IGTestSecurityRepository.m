//
//  IGTestSecurityRepository.m
//  salesforce
//
//  Created by Armando Restrepo on 12/26/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "IGTestSecurityRepository.h"
#import "IGError.h"
#import "IGAPIClient.h"
#import "IGAuthenticationRequest.h"
#import "IGAuthenticationResponse.h"
#import "IGQuestion.h"

@interface IGTestSecurityRepository ()

-(NSDictionary *) loadLoginModelFromFile:(NSString *) fileName;

@end

@implementation IGTestSecurityRepository{
NSURLProtectionSpace *loginProtectionSpace;
}

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (id) init {
    if (_sharedInstance){
        return _sharedInstance;
    }
    else{
        if (self = [super init]){
            loginProtectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"appmovil.oldmutual.com" port:80 protocol:@"http" realm:nil authenticationMethod:nil];
        }
        return self;
    }
}

-(void)autoLogin:(void (^)(IGAuthenticationResponse *response, NSError *error))block {
    
    if (![[IGAPIClient sharedInstance] isNetworkAvailable]){
        if (block) {
            block(nil, [IGError defaultNoInternetConnectionError]);
        }
        return;
    }
    NSError *error = [[NSError alloc] initWithDomain:IGAppDomain code:IGErrorInvalidValue userInfo:nil];
    NSURLCredential *credential;
    NSDictionary *credentials;
    
    credentials = [[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:loginProtectionSpace];
    credential = [credentials.objectEnumerator nextObject];
    
    if (credential) {
        IGAuthenticationRequest *request = [[IGAuthenticationRequest alloc]init];
        request.login = credential.user;
        request.password = credential.password;
        [self login:request withBlock:block];
    } else {
        block(nil, error);
    }
}

-(void)login:(IGAuthenticationRequest *)request withBlock:(void (^)(IGAuthenticationResponse *response, NSError *error))block {

    //    if (![[IGAPIClient sharedInstance] isNetworkAvailable]){
    //        if (block) {
    //            block(nil, [IGError defaultNoInternetConnectionError]);
    //        }
    //        return;
    //    }
    
    IGAuthenticationResponse *response = nil;
    NSError *error = nil;
    if ([request.login isEqualToString:@"test"] && [request.password isEqualToString:@"12"]) {
    
        NSURLCredential *credential;
        credential = [NSURLCredential credentialWithUser:request.login password:request.password persistence:NSURLCredentialPersistencePermanent];
        [[NSURLCredentialStorage sharedCredentialStorage] setCredential:credential forProtectionSpace:loginProtectionSpace];
        
        NSDictionary *login = [self loadLoginModelFromFile:@"login"];
            
        response = [MTLJSONAdapter modelOfClass:[IGAuthenticationResponse class] fromJSONDictionary:login error:nil];
        
        error = nil;
        
    }else if([request.login isEqualToString:@"test"] && [request.password isEqualToString:@"clave"]){
        
        NSURLCredential *credential;
        credential = [NSURLCredential credentialWithUser:request.login password:request.password persistence:NSURLCredentialPersistencePermanent];
        [[NSURLCredentialStorage sharedCredentialStorage] setCredential:credential forProtectionSpace:loginProtectionSpace];
        
        IGQuestion *question = [[IGQuestion alloc] init];
        question.questionId = [NSNumber numberWithInt:1];
        question.text = @"Ingrese su clave";
        question.type = [NSNumber numberWithInt:1];
        NSArray *questions = [[NSArray alloc] initWithObjects:question, nil];
        
        
        IGPendingActionRequest *pendingActionRequest = [[IGPendingActionRequest alloc] init];
        pendingActionRequest.name = @"Cambio de clave";
        pendingActionRequest.pendingActionType = 1;
        pendingActionRequest.failAttempts = 0;
        pendingActionRequest.message= @"Usuario, debe cambiar su clave";
        pendingActionRequest.questions = questions;
        
        response = [[IGAuthenticationResponse alloc] init];
        response.docNumber = nil;
        response.docType = nil;
        response.authenticationStatus = 0;
        response.authenticationMessage = @"Apreciado cliente usted debe cambiar su clave";
        response.token =nil;
        response.failedAttempts = 0;
        response.pendingActionRequest = pendingActionRequest;
        
        error = nil;
        
    }else{
        error =[ IGError defaultInvalidCredentialError];
    }
    
    if (block) {
         block(response, error);
    }
}

-(void)loginForRestorePass:(IGForgotPasswordRequest *)request withBlock:(void (^)(IGForgotPasswordResponse *, NSError *))block
{
    //test data
}

-(void)logout {
    NSURLCredential *credential;
    NSDictionary *credentials;
    
    credentials = [[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:loginProtectionSpace];
    credential = [credentials.objectEnumerator nextObject];
    
    if (credential){
        [[NSURLCredentialStorage sharedCredentialStorage] removeCredential:credential forProtectionSpace:loginProtectionSpace];
    }
}

-(NSDictionary *) loadLoginModelFromFile:(NSString *) fileName {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err = nil;
    
    NSDictionary *items = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    return items;
    
}

@end
