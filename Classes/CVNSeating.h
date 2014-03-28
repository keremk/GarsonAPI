//
//  CVNTable.h
//  Pods
//
//  Created by Kerem Karatal on 3/27/14.
//
//

#import <Foundation/Foundation.h>

@interface CVNSeating : NSObject

- (void) seating:(NSString *) seatingId willNotifyWhenUsersCheckin:(void (^)(NSArray *users))usersCheckedIn;

@end
