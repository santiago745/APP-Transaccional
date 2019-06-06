//
//  IGError.m
//  salesforce
//
//  Created by Juan on 24/12/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "IGError.h"

NSString * const IGAppDomain = @"com.oldmutual.mobileapp";

@implementation IGError

+(IGError *) IGErrorFromAFNetworkingError:(NSError *) error
                            withOperation:(AFHTTPRequestOperation *) operation {

    NSInteger code = error.code;
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithDictionary:error.userInfo];
    
    if (operation) {
        code = operation.response.statusCode;
        if (code == 0) {
            code = error.code;
            if (code == -1001) {
                return [IGError defaultRequestTimeoutError];
            }
            
            if (code == -1004) {
                return [IGError defaultNoInternetConnectionError];
            }
        }
        @try {
            NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err = nil;
            
            if (data) {
                NSDictionary *items = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                
                if (!err && items) {
                    
                    NSString *serviceCode = [items valueForKey:@"code"];
                    
                    if ([serviceCode isEqualToString:@"00003"]) {
                        code = IGErrorInvalidCredentialService;
                    }
                    
                    if ([serviceCode isEqualToString:@"00001"]) {
                        code = IGErrorNoCredential;
                    }
                    
                    if ([items valueForKey:@"message"]) {
                        [userInfo setValue:[items valueForKey:@"message"] forKey:NSLocalizedRecoverySuggestionErrorKey];
                    }
                    
                }
            }
        }
        @catch (NSException *exception) {
            //NSLog(@"Error: %@", exception );
        }
    }
    
    return [[IGError alloc] initWithDomain:IGAppDomain code:code userInfo:userInfo];
}

+(IGError *) defaultError:(NSInteger) code withMessage:(NSString *) message {
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setValue:message forKey:NSLocalizedRecoverySuggestionErrorKey];
    
    return [[IGError alloc] initWithDomain:IGAppDomain code:code userInfo:userInfo];
}

+(IGError *) defaultInvalidCredentialError{
    
    return [IGError defaultError:IGErrorInvalidCredential withMessage:IGErrorInvalidCredentialMessage];
    
}

+(IGError *) defaultInvalidUserValuesFromLoginError{

    return [IGError defaultError:IGErrorInvalidUserValuesFromLogin withMessage:IGErrorInvalidUserValuesFromLoginMessage];

}

+(IGError *) defaultNoInternetConnectionError{
    
    return [IGError defaultError:IGErrorNoInternetConnection withMessage:IGErrorNoInternetConnectionMessage];
    
}

+(IGError *) defaultRequestTimeoutError{
    
    return [IGError defaultError:IGErrorRequestTimeout withMessage:IGErrorRequestTimeoutMessage];

}

+(IGError *) defaultEndOfSearchError{

    return [IGError defaultError:IGErrorEndOfSearch withMessage:IGErrorEndOfSearchMessage];
    
}

+(IGError *) defaultCouchBaseError{
    
    return [IGError defaultError:IGErrorCouchBase withMessage:IGErrorCouchBaseMessage];
    
}

@end
