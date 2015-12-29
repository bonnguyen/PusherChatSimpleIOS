//
//  ViewController.h
//  PusherChatSimpleIOS
//
//  Created by Nguyen Bon on 12/9/15.
//  Copyright © 2015 SmartDev LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblChatRoom;
@property (weak, nonatomic) IBOutlet UITextField *tfMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;


@end

