//
//  CVNTable.h
//  Pods
//
//  Created by Kerem Karatal on 3/27/14.
//
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface CVNSeating : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSArray *registeredUsers;
@property(nonatomic, assign) NSInteger seatingId;

+ (void) findBySeatingId:(NSInteger) seatingId
                 success:(void (^)(CVNSeating *seating))success
                 failure:(void (^)(NSError *error))failure;
- (void) seating:(NSString *) seatingId willNotifyWhenUsersCheckin:(void (^)(NSArray *users))usersCheckedIn;

@end
