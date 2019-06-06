//
//  Strings.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/20/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#ifndef MobileApp_Strings_h
#define MobileApp_Strings_h

static NSString * const IGEmptyString = @"";
static NSString * const IGErrorTitleCodeFormat = @"Código del error: %d";

//Text
#define OM_TXT_ACCEPT @"ACEPTAR"
#define OM_TXT_CANCEL @"CANCELAR"
#define OM_TXT_CLOSE @"FINALIZAR"
#define OM_TXT_ERROR @"Error"
#define OM_TXT_OK @"OK"
#define IG_PENDING_ACTION_NAME_REGISTER @"Registrar"
#define IG_PENDING_ACTION_NAME_VALIDATE @"Validar"
#define IG_NOTIFICATION_SAFEEXIT @"saveExit"
#define OM_NOTIFICATION_CHANGE_PASS_CANCELED @"changePassCanceled"
#define OM_TXT_RESTORE_PASSWORD @"Restablecer Contraseña"
#define OM_TXT_ASK_QUESTION @"Registro de Preguntas"
#define OM_TXT_TERMS_CONDITIONS @"Términos y condiciones"
#define OM_TXT_SECURITY_QUESTIONS @"Preguntas de seguridad"
#define OM_TXT_LABEL_ENTRY_DATE @"Su último ingreso fué el: %@"
#define OM_TXT_LABEL_IP @"Dirección IP: %@"
#define OM_TXT_BALANCE_CONTRACT_LABEL @"Saldo Total: %@"
#define OM_TXT_KEY_PRODUCT_CONTRACT @"NombreComercialProducto"
#define OM_TXT_KEY_BALANCE_CONTRACT @"Saldo"
#define OM_TXT_CONTRACT_DETAIL_LABEL_IPHONE @"Contrato %@"
#define OM_TXT_CONTRACT_DETAIL_TITLE_LABEL_IPHONE @"Detalle del Contrato"
#define OM_TXT_CONTRACT_DETAIL_LABEL_IPAD @"Detalle del Contrato %@"
#define OM_TXT_CERTIFICATE @"Certificados"
#define OM_TXT_GENERATE_CERTIFICATE @"Certificado Afiliación"
#define OM_TXT_OTHERS @"Ingrese a quien va dirigido"
#define OM_TXT_CERTIFICATE_NAME @"Certificado tributario"
#define OM_TXT_EXTRACT @"Extractos"
#define OM_TXT_EXTRACT_NAME @"Extracto"
#define OM_TXT_AGENT @"Mis Agentes"
#define OM_TXT_BALANCE @"Saldos"
#define OM_TXT_CONTRACT @"Contrato"
#define OM_TXT_HISTORICAL @"Transacciones"
#define OM_TXT_AGENT_DETAIL_TITLE @"Mi Agente"
#define OM_TXT_TRANSACTION_TITLE @"Histórico de Transacciones"
#define OM_TXT_TRANSACTION_LABEL_IPHONE @"Contrato %@"
#define OM_TXT_TRANSACTION_LABEL_IPAD @"Histórico de Transacciones Contrato %@"
#define OM_TXT_TRANSACTION_DETAIL @"Detalle Histórico"
#define OM_TXT_TRANSACTION_DETAIL_TITLE @"Detalle de la Transacción"

//Labels
#define OM_LABEL_ASKQUESTIONS_INSTRUCTIONS @"Por favor responda las siguientes preguntas para poder continuar."
#define OM_LABEL_SHOWREGISTEREDQUESTIONS_INSTRUCTIONS @"Hemos registrado las siguientes preguntas en nuestros sistemas de información."
#define OM_LABEL_CHANGEPASSWORD_INSTRUCTIONS @"Hemos registrado las siguientes preguntas en nuestros sistemas de información."

//Messages
#define OM_FIRST_TIME_MESSAGE @"Para el uso del app transaccional debe tener registrado usuario y contraseña en el portal de clientes."
#define OM_MESSASGE_CHANGEPASSWORD_PASSWORDREQUIRED @"El campo contraseña no puede estar vacio"
#define OM_MESSASGE_CHANGEPASSWORD_PASSWORDCONFIRMATIONREQUIRED @"Debe ingresar una confirmación de contraseña"
#define OM_MESSASGE_CHANGEPASSWORD_PASSWORDDOESNOTMATCH @"Las contraseñas no coinciden"
#define OM_MESSASGE_CHANGEPASSWORD_PASSWORDCONSECUTIVECHARS @"No pueden haber dos caracteres consecutivos repetidos"
#define OM_MESSASGE_CHANGEPASSWORD_PASSWORDNOTSECURE @"La contraseña no cumple los requerimientos mínimos"
#define OM_MESSAGE_LOGIN_USERREQUIRE @"Debe ingresar un nombre de usuario"
#define OM_MESSAGE_LOGIN_PASSREQUIRE @"Debe ingresar una contraseña"
#define OM_MESSAGE_REGISTERQUESTION_QUESTIONREQUIRED @"Debe seleccionar una pregunta"
#define OM_MESSAGE_REGISTERQUESTION_ANSWERREQUIRED @"Debe ingresar una respuesta"
#define OM_MESSAGE_REGISTERQUESTION_VALIDATEREGEX @"La respuesta no cumple los requerimientos mínimos"
#define OM_MESSAGE_REGISTERQUESTION_CONFIRMANSWER @"Debe ingresar una confirmación de la respuesta"
#define OM_MESSAGE_REGISTERQUESTION_MATCHANSWER @"Las respuestas no coinciden"
#define OM_MESSAGE_LOGIN_ERRORONSERVICE @"Ha ocurrido un error, intente de nuevo más tarde"
#define OM_MESSAGE_FORGOTPASS_DOCUMENTTYPEREQUIERED @"Debe seleccionar un tipo de documento "
#define OM_MESSAGE_FORGOTPASS_DOCUMENTNUMBERREQUIRED @"Debe ingresar un número de documento"
#define OM_MESSAGE_FORGOTPASS_EMAILREQUIRED @"Debe ingresar un correo electrónico"
#define OM_MESSAGE_FORGOTPASS_EMAILFORMAT @"El correo electrónico es inválido"
#define OM_MESSAGE_FORGOTPASS_DATEREQUIRED @"Debe seleccionar una fecha de nacimiento"
#define OM_MESSAGE_GENERAL_SESSIONCLOSED @"La sesión ha expirado por inactividad superior a 5 minutos. Por favor ingrese nuevamente."
#define OM_DEAR_CLIENT @"Apreciado Cliente"
#define OM_MESSASGE_FIELDREQUIRED @"El campo 'Dirigido a' no puede estar vacío"

//Alert View
#define OM_ALERT_REGISTERQUESTION_ALERTERRORMESSAGE @"Para continuar con el inicio de sesión y para su seguridad es necesario que registre cinco preguntas de seguridad. "
#define OM_ALERT_RESTOREPASS_ALERTERRORMESSAGE @"Para restablecer su contraseña y enviarle una nueva, debe tener registrado su correo electrónico en nuestros sistemas de información. \n \n Si aún no lo tiene, comuníquese con nuestros Analistas del Contact Center al (031) 658 4000 en bogotá, o al 018000 517526 a nivel nacional, de lunes a viernes de 8:00am a 7:00pm y sábados de 9:00am a 1:00pm."
#define OM_ALERT_REGISTERQUESTION_CANCELQUESTIONS_TITTLE @"Alerta"
#define OM_ALERT_REGISTERQUESTION_CANCELQUESTIONS_MESSAGE @"Esta acción no guardará ninguna de las preguntas y respuestas dadas hasta el momento, y reiniciará todo el proceso. ¿Desea continuar?"
#define OM_TXT_CLOSE_SESION @"¿Desea cerrar la sesión?"
#define OM_ALERT_REGISTERDEVICE_ALERTTITTLE @"¿Desea registrar su equipo?"
#define OM_ALERT_REGISTERDEVICE_ALERTMESSAGE @"Usted puede registrar los equipos de uso frecuente y seguro si desea que el sistema los reconozca al ingresar al Portal de Clientes"
#define OM_ALERT_REGISTERDEVICE_SUCCESSCHANGE_TITLE @"Cambio exitoso"
#define OM_ALERT_REGISTERDEVICE_SUCCESSCHANGE @"El cambio de clave se ha realizado exitosamente"
#define OM_ALERT_TERMSANDCONDITIONS_ALERTMESSAGE @"Es necesario aceptar los términos y condiciones para ingresar al portal"
#define OM_ALERT_GENERATE_CERTIFICATE @"El contrato no cuenta con certificado para generar"
//Alert send email
#define OM_ALERT_TITLE_SEND_EMAIL @"Enviado"
#define OM_ALERT_MESSAGE_SEND_EMAIL @"Correo enviado satisfactoriamente"
#define OM_ALERT_MESSAGE_SEND_EMAIL_ERROR @"El correo no pudo ser enviado: %@"

//Document type list
#define OM_ARRAY_FORGOTPASS_DOCUMENT_TYPES_LIST  [NSDictionary dictionaryWithObjectsAndKeys: @"Cédula de Ciudadanía", @"C", @"Cédula de Extranjería", @"E", @"Carnet Minist Relac Exter", @"L", @"Nit Persona Natural", @"M", @"Identificación Tributaria", @"N", @"Pasaporte", @"P", @"Registro Civil", @"R", @"Tarjeta Identidad", @"T", nil];

#define OM_ARRAY_FORGOTPASS_DOCUMENT_TYPES_VALUES [NSArray arrayWithObjects:@"Cédula de Ciudadanía", @"Cédula de Extranjería", @"Carnet Minist Relac Exter", @"Nit Persona Natural", @"Identificación Tributaria", @"Pasaporte", @"Registro Civil", @"Tarjeta Identidad", nil];

#define OM_ARRAY_FORGOTPASS_DOCUMENT_TYPES_KEYS [NSArray arrayWithObjects:@"C", @"E", @"L", @"M", @"N", @"P", @"R", @"T", nil];

#define OM_ARRAY_IMAGE_ITEM_LOGIN [NSArray arrayWithObjects:@"icon_stats", @"icon_calc", @"icon_alert", nil];
#define OM_ARRAY_TITLE_ITEM_LOGIN [NSArray arrayWithObjects:@"Rentabilidades", @"Simuladores", @"Canales de Contacto", nil];
#define OM_ARRAY_DESCRIPTION_ITEM_LOGIN [NSArray arrayWithObjects:@"Conozca la rentabilidad histórica de nuestros productos", @"Herramientas que le facilitan su planeación financiera", @"Ponemos a su disposición los distintos canales de servicio", nil];
#define OM_ARRAY_WEB_ITEM_LOGIN [NSArray arrayWithObjects:@"https://portal.oldmutual.com.co/om.rentabilidades.pl/oldmutual", @"https://portal.oldmutual.com.co/sites/simuladores/index.php", @"", nil];

#define OM_ARRAY_COLORS [NSArray arrayWithObjects:[UIColor colorWithRed:110 / 255.0 green:171 / 255.0 blue:36 / 255.0 alpha:1.0f], [UIColor colorWithRed:234 / 255.0 green:133 / 255.0 blue:37 / 255.0 alpha:1.0f], [UIColor colorWithRed:0 / 255.0 green:176 / 255.0 blue:202 / 255.0 alpha:1.0f], [UIColor colorWithRed:0 / 255.0 green:97 / 255.0 blue:80 / 255.0 alpha:1.0f], [UIColor colorWithRed:131 / 255.0 green:0 / 255.0 blue:81 / 255.0 alpha:1.0f], [UIColor colorWithRed:110 / 255.0 green:171 / 255.0 blue:36 / 255.0 alpha:1.0f], [UIColor colorWithRed:234 / 255.0 green:133 / 255.0 blue:37 / 255.0 alpha:1.0f], [UIColor colorWithRed:0 / 255.0 green:176 / 255.0 blue:202 / 255.0 alpha:1.0f], [UIColor colorWithRed:0 / 255.0 green:97 / 255.0 blue:80 / 255.0 alpha:1.0f], [UIColor colorWithRed:131 / 255.0 green:0 / 255.0 blue:81 / 255.0 alpha:1.0f], nil];

#define OM_ARRAY_TAG_PICKER [NSArray arrayWithObjects:@201, @202, @203, @204, @205, nil];
#define OM_ARRAY_TAG_DATE_PICKER [NSArray arrayWithObjects:@301, @302, @303, @304, @305, nil];

//Pickers
#define OM_PICKER_FORGOTPASS_DOCUMENT_TYPES_TITTLE @"Documento"
#define OM_PICKER_FORGOTPASS_DATEPICKER_TITTLE @"Fecha"
#define OM_PICKER_DATE_FORMAT @"yyyy/MM/dd"

#endif
