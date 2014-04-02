//
//  CVNMenuItem.h
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import <Mantle/Mantle.h>

@interface CVNMenuItem : MTLModel<MTLJSONSerializing>
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, strong) NSURL *imageURL;
@property(nonatomic, assign) double price;

- (NSString *) formattedPrice;
@end
