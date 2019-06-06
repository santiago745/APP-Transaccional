//
//  IGError.h
//  salesforce
//
//  Created by Juan on 24/12/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

FOUNDATION_EXPORT NSString *const IGAppDomain;

enum {
    IGErrorInvalidValue = 13001,
    IGErrorEndOfSearch = 13002,
    IGErrorNoCredential = 13003,
    IGErrorInvalidCredential = 13004,
    IGErrorInvalidCredentialService = 130040,
    IGErrorInvalidUserValuesFromLogin = 13005,
    IGErrorNoInternetConnection = 13006,
    IGErrorRequestTimeout = 13007,
    IGErrorCouchBase = 13008
};/* errors that finish with zero by server*/

static NSString * const IGErrorInvalidCredentialMessage = @"Usuario o contraseña incorrectos. Por favor intenta de nuevo.";

static NSString * const IGErrorInvalidUserValuesFromLoginMessage = @"Tus datos de usuario no coinciden con el rol asignado. Por favor contacta al administrador.";

static NSString * const IGErrorNoInternetConnectionMessage = @"Error de conexión.  Por favor verifica que tengas una conexión a internet activa.";

static NSString * const IGErrorRequestTimeoutMessage = @"La solicitud está tardando demasiado. Por favor inténtalo nuevamente.";

static NSString * const IGErrorEndOfSearchMessage = @"No se encontraron resultados.";

static NSString * const IGErrorCouchBaseMessage = @"Ha ocurrido un error en la base de datos.";


@interface IGError : NSError

@property (nonatomic) BOOL isIGError;

+(IGError *) IGErrorFromAFNetworkingError:(NSError *) error
                            withOperation:(AFHTTPRequestOperation *) operation;

+(IGError *) defaultInvalidCredentialError;

+(IGError *) defaultInvalidUserValuesFromLoginError;

+(IGError *) defaultNoInternetConnectionError;

+(IGError *) defaultRequestTimeoutError;

+(IGError *) defaultEndOfSearchError;

+(IGError *) defaultCouchBaseError;

@end
