//
//  Conversation.m
//  PusherChatSimpleIOS
//
//  Created by Nguyen Bon on 12/15/15.
//  Copyright © 2015 SmartDev LLC. All rights reserved.
//

#import "Conversation.h"
#import "Constants.h"

@implementation Conversation

@synthesize username, message, date;

- (BOOL) isSent {
    return [username isEqualToString:FAKE_USER_DATA];
}

@end
