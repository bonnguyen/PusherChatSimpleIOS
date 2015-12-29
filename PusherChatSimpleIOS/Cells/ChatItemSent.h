//
//  ChatItemSent.h
//  PusherChatSimpleIOS
//
//  Created by Nguyen Bon on 12/15/15.
//  Copyright © 2015 SmartDev LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatItemSent : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;

@end
