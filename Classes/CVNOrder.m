//
//  CVNOrder.m
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import "CVNOrder.h"
#import "CVNOrderItem.h"
#import "MTLJSONAdapter.h"

@implementation CVNOrder
+ (CVNOrder *) currentOrder {
  CVNOrder *currentOrder = [[CVNOrder alloc] init];
  
  return currentOrder;
}

- (NSArray *) orderItems {
  NSArray *mockItems = @[@{@"name": @"Brussel Sprouts",
                           @"description": @"Brussels Sprouts w/ Pineapple Chili Glaze & Crispy Shallots",
                           @"image": @"https://s3-us-west-2.amazonaws.com/garson-menu-items/sample_restaurant/brussels-sprouts-with-bacon.jpg",
                           @"price": @(12.0),
                           @"item_count": @(1)
                           },
                         @{@"name": @"Pork Ribs",
                           @"description": @"Hi Lo chili rub",
                           @"image": @"https://s3-us-west-2.amazonaws.com/garson-menu-items/sample_restaurant/rib_tips.jpg",
                           @"price": @(20.0),
                           @"item_count": @(2)
                           }
                         ];
  NSMutableArray *orderItems = [NSMutableArray array];
  [mockItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSDictionary *dict = (NSDictionary *) obj;
    NSError *error;
    CVNOrderItem *orderItem = [MTLJSONAdapter modelOfClass:CVNOrderItem.class fromJSONDictionary:dict error:&error];
    [orderItems addObject:orderItem];
  }];

  return orderItems;
}
@end
