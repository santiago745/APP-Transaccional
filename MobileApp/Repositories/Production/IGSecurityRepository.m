//
//  IGSecurityRepository.m
//  salesforce
//
//  Created by Armando Restrepo on 12/26/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "IGSecurityRepository.h"
#import "IGAPIClient.h"
#import "IGAuthenticationRequest.h"
#import "IGAuthenticationResponse.h"
#import "IGForgotPasswordRequest.h"
#import "IGForgotPasswordResponse.h"
#import "MTLJSONAdapter.h"
@interface IGSecurityRepository ()
@property (nonatomic, strong) NSURLProtectionSpace *loginProtectionSpace;
@property (nonatomic, strong, readwrite)  NSURLCredential *urlCredential;
@end

@implementation IGSecurityRepository

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
            self.loginProtectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"appmovil.oldmutual.com" port:80 protocol:@"http" realm:nil authenticationMethod:nil];
        }
        return self;
    }
}

-(NSURLCredential *) urlCredential {
    
    if (!_urlCredential) {
        NSDictionary *credentials;
        
        credentials = [[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:self.loginProtectionSpace];
        _urlCredential = [credentials.objectEnumerator nextObject];
    }
    return _urlCredential;
    
}

-(void)autoLogin:(void (^)(IGAuthenticationResponse *response, NSError *error))block {
    
    if (self.urlCredential) {
        IGAuthenticationRequest *request = [[IGAuthenticationRequest alloc]init];
        request.login = self.urlCredential.user;
        request.password = self.urlCredential.password;
        [self login:request withBlock:^(IGAuthenticationResponse *response, NSError *error) {
            if (error) { /* validate error code 401 or 00003*/
                [self logout];
            }
            block(response, error);
        }];
    } else {
        //        NSError *error = [[NSError alloc] initWithDomain:IGPaperlessDomain code:IGErrorNoCredential userInfo:nil];
        NSError *error;
        block(nil, error);
    }
}

-(void)login:(IGAuthenticationRequest *)request
   withBlock:(void (^)(IGAuthenticationResponse *response, NSError *error))block {
    
//    if (![[IGAPIClient sharedInstance] isNetworkAvailable]){
//        if (block) {
//            block(nil, [IGError defaultNoInternetConnectionError]);
//        }
//        return;
//    }
    
    NSDictionary *requestJson = [MTLJSONAdapter JSONDictionaryFromModel:request];
    
    __weak typeof (self) weakSelf = self;
    
  
    
    [[IGAPIClient sharedInstance] POST:@"Auth" parameters:requestJson success:^(AFHTTPRequestOperation *operation, id responseObject) {
         operation.securityPolicy.allowInvalidCertificates = YES;
        operation.securityPolicy.validatesDomainName = NO;
        if (block) {
            if (![responseObject objectForKey:@"Message"] && ![[responseObject objectForKey:@"Text"] isEqualToString:IGEmptyString]){
                
                IGAuthenticationResponse *response = [MTLJSONAdapter modelOfClass:[IGAuthenticationResponse class] fromJSONDictionary:responseObject error:nil];
                
                if (response.pendingActionRequest == nil && response.token != nil &&
                    response.authenticationStatus == 1) {
                    //Login success grab credentials on keychain
                    NSURLCredential *credential;
                    credential = [NSURLCredential credentialWithUser:request.login
                                                            password:request.password persistence:NSURLCredentialPersistencePermanent];
                    [[NSURLCredentialStorage sharedCredentialStorage] setCredential:credential forProtectionSpace:weakSelf.loginProtectionSpace];
                    
                }
                
                block(response,nil);
            }else{
                //block(nil, [IGError defaultemptyData]);
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
}

-(void)loginForRestorePass:(IGForgotPasswordRequest *)request
   withBlock:(void (^)(IGForgotPasswordResponse *response, NSError *error))block {
    
//    if (![[IGAPIClient sharedInstance] isNetworkAvailable]){
//        if (block) {
//            block(nil, [IGError defaultNoInternetConnectionError]);
//        }
//        return;
//    }
    
    NSDictionary *requestJson = [MTLJSONAdapter JSONDictionaryFromModel:request];
    
    [[IGAPIClient sharedInstance] POST:@"ForgotPassword" parameters:requestJson success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            
            IGForgotPasswordResponse *response = [MTLJSONAdapter modelOfClass:[IGForgotPasswordResponse class] fromJSONDictionary:responseObject error:nil];
                
            block(response,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            int code = [operation.response statusCode];
            NSLog(@"Error -> %@", operation.responseString);
            block(nil, [[IGAPIClient sharedInstance] handleError:error withOperation:operation]);
        }
    }];
}

-(void)logout {
    NSURLCredential *credential;
    NSDictionary *credentials;
    
    credentials = [[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:self.loginProtectionSpace];
    credential = [credentials.objectEnumerator nextObject];
    if (credential) {
        [[NSURLCredentialStorage sharedCredentialStorage] removeCredential:credential forProtectionSpace:self.loginProtectionSpace];
    }
    
}

@end
