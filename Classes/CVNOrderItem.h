//
//  CVNOrderItem.h
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import <Mantle/Mantle.h>

@interface CVNOrderItem : MTLModel<MTLJSONSerializing>
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, strong) NSURL *imageURL;
@property(nonatomic, assign) double price;
@property(nonatomic, assign) NSUInteger itemCount;

- (NSString *) formattedItemCount;
- (NSString *) formattedPrice;
@end
