//
//  CVNRestaurant.m
//  Pods
//
//  Created by Kerem Karatal on 4/1/14.
//
//

#import "CVNRestaurant.h"
#import "CVNSession.h"

#import <AFNetworking/AFNetworking.h>

static NSString * const kTempMenuResourceURL = @"https://s3-us-west-2.amazonaws.com/garson-menu-items/hi-lo-sample/hi_lo_sample.json";

@implementation CVNRestaurant

+ (instancetype) currentRestaurant {
  CVNRestaurant *restaurant = [[CVNRestaurant alloc] init];
  restaurant.name = @"HiLo BBQ";
  return restaurant;
}

- (void) currentMenuWithSuccess:(void (^)(CVNRestaurantMenu *menu))success
                        failure:(void (^)(NSError *error))failure {
  
  // For now we will read this here, but this logic will be handled in CVNSession later
  
  NSString *filePath = [[NSBundle bundleForClass: [CVNRestaurant class]] pathForResource:@"hi_lo_sample" ofType:@"json"];
  NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
  NSError *error;
  NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
  CVNRestaurantMenu *menu = [MTLJSONAdapter modelOfClass:CVNRestaurantMenu.class fromJSONDictionary:jsonDict error:&error];
  success(menu);
  
//  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//  AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
//  
//  [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//  [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//  manager.requestSerializer = requestSerializer;
//  [manager GET:kTempMenuResourceURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    NSDictionary *userDict = (NSDictionary *) responseObject;
//    NSError *error;
//    CVNRestaurantMenu *menu = [MTLJSONAdapter modelOfClass:CVNRestaurantMenu.class fromJSONDictionary:userDict error:&error];
//    success(menu);
//    NSLog(@"JSON: %@", responseObject);
//  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    NSLog(@"Error: %@", error);
//  }];
}
@end
