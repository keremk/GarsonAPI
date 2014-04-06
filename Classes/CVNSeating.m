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

static NSString * const kRegisteredUsers = @"registered_users";
static NSString * const kSeatingId = @"seating_id";

@implementation CVNSeating

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"registeredUsers": kRegisteredUsers,
           @"seatingId": kSeatingId
           };
}

+ (void) findBySeatingId:(NSInteger) seatingId
                 success:(void (^)(CVNSeating *seating))success
                 failure:(void (^)(NSError *error))failure {
  NSDictionary *mockSeatings = [CVNSeating mockSeatings];
  NSString *seatingIdString = [NSString stringWithFormat:@"%lu", (long) seatingId];
  
  NSDictionary *dict = [mockSeatings objectForKey:seatingIdString];
  NSError *error;
  CVNSeating *seating = [MTLJSONAdapter modelOfClass:CVNSeating.class fromJSONDictionary:dict error:&error];
  success(seating);
}

+ (NSValueTransformer *) registeredUsersJSONTransformer {
  return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:CVNUser.class];
}


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

+ (NSDictionary *) mockSeatings {
  NSDictionary *mockSeatings = @{@"46122": @{@"registered_users": @[
                                            @{@"userId": @"a1b1c1d1e1",
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
                                              }
                                            ],
                                             @"seating_id": @(46122)},
                                 @"44924": @{@"registered_users": @[
                                            @{@"userId": @"a4b1c1d1e1",
                                              @"image": @"https://s3.amazonaws.com/uifaces/faces/twitter/walterstephanie/128.jpg",
                                              @"display_name": @"walterstephanie"
                                              },
                                            @{@"userId": @"a5b1c1d1e1",
                                              @"image": @"https://s3.amazonaws.com/uifaces/faces/twitter/atariboy/128.jpg",
                                              @"display_name": @"atariboy"
                                              }
                                            ],
                                             @"seating_id": @(44924)}                                             
                                 };
  return mockSeatings;
}

@end
