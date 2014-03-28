//
//  CVNUser.h
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import "Mantle.h"

static NSString * const kUniqueId = @"unique_id";
static NSString * const kGuest = @"guest";
static NSString * const kPrimaryAccount = @"primary_account";
static NSString * const kAccountId = @"account_id";
static NSString * const kCredentials = @"credentials";
static NSString * const kCredentialsConfirmation = @"credentials_confirmation";
static NSString * const kDisplayName = @"display_name";
static NSString * const kName = @"name";
static NSString * const kImage = @"image";
static NSString * const kEmail = @"email";
static NSString * const kGender = @"gender";
static NSString * const kDateOfBirth = @"date_of_birth";
static NSString * const kAge = @"age";
static NSString * const kCity = @"city";
static NSString * const kState = @"state";
static NSString * const kCountry = @"country";
static NSString * const kLocale = @"locale";

@interface CVNUser : MTLModel<MTLJSONSerializing>

@property(nonatomic, copy) NSString *userId;
@property(nonatomic) BOOL guest;
@property(nonatomic, copy) NSString *primaryAccount;
@property(nonatomic, copy) NSString *accountId;
@property(nonatomic, copy) NSString *displayName;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong, readonly) NSURL *imageURL;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *gender;
@property(nonatomic, strong) NSDate *dateOfBirth;
@property(nonatomic) NSUInteger age;
@property(nonatomic, copy) NSString *education;
@property(nonatomic, copy) NSString *handedness;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *state;
@property(nonatomic, copy) NSString *country;
@property(nonatomic, copy) NSString *locale;

@end

