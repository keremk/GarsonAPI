//
//  CVNUser.h
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import <Mantle/Mantle.h>
#import "CVNOrder.h"

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

@property(nonatomic, strong) CVNOrder *currentOrder;
@end

