//
//  Conversation.h
//  PusherChatSimpleIOS
//
//  Created by Nguyen Bon on 12/15/15.
//  Copyright © 2015 SmartDev LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conversation : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDate *date;

- (BOOL) isSent;

@end
