//
//  CVNTable.m
//  Pods
//
//  Created by Kerem Karatal on 3/27/14.
//
//


#import "CVNSeating.h"
#import "CVNUser.h"

#import <Mantle/MTLJSONAdapter.h>

@implementation CVNSeating

- (void) seating:(NSString *) seatingId willNotifyWhenUsersCheckin:(void (^)(NSArray *users))usersCheckedIn {
  NSArray *users = [self readUsers];
  usersCheckedIn(users);
}

- (NSArray *) readUsers {
  NSArray *mockData = @[@{@"userId": @"a1b1c1d1e1",
                          @"image": @"https://s3.amazonaws.com/uifaces/faces/twitter/adellecharles/128.jpg",
                          @"display_name": @"adellecharles"
                          },
                        @{@"userId": @"a2b1c1d1e1",
                          @"image": @"https://s3.amazonaws.com/uifaces/faces/twitter/soffes/128.jpg",
                          @"display_name": @"soffes"
                          },
                        @{@"userId": @"a3b1c1d1e1",
                          @"image": @"https://s3.amazonaws.com/uifaces/faces/twitter/divya/128.jpg",
                          @"display_name": @"divya"
                          },
                        ];

  NSMutableArray *users = [NSMutableArray array];
  
  [mockData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSDictionary *dict = (NSDictionary *) obj;
    NSError *error;
    CVNUser *friendUser = [MTLJSONAdapter modelOfClass:CVNUser.class fromJSONDictionary:dict error:&error];
    [users addObject:friendUser];
  }];
  return users;
}


@end
