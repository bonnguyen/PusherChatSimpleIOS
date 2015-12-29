//
//  ViewController.m
//  PusherChatSimpleIOS
//
//  Created by Nguyen Bon on 12/9/15.
//  Copyright © 2015 SmartDev LLC. All rights reserved.
//

#import "ViewController.h"
#import "Conversation.h"
#import "ChatItemRcv.h"
#import "ChatItemSent.h"
#import "Constants.h"
#import <Pusher/Pusher.h>
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()<PTPusherDelegate> {
    PTPusher *client;
    NSMutableArray *chatList;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    chatList = [[NSMutableArray alloc] init];
    
    [self.tblChatRoom setDelegate:self];
    [self.tblChatRoom setDataSource:self];
    
    client = [PTPusher pusherWithKey:@"a23a160d93f93ade6019" delegate:self encrypted:YES];
    
    // Subcribe to channel and bind to event
    PTPusherChannel *channel = [client subscribeToChannelNamed:@"test_channel"];
    [channel bindToEventNamed:@"my_event" handleWithBlock:^(PTPusherEvent *channelEvent){
        // channelEvent.data is a NSDictionary of the JSON Object received
        NSString *date = [channelEvent.data objectForKey:@"date"];
        NSString *message = [channelEvent.data objectForKey:@"message"];
        NSString *username = [channelEvent.data objectForKey:@"username"];
        NSLog(@"date %@", date);
        NSLog(@"Message %@", [message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]);
        NSLog(@"username %@", username);
        
        Conversation *conversation = [[Conversation alloc] init];
        conversation.username = username;
        conversation.message = message;
        
        if(nil != chatList) {
            [chatList addObject:conversation];
            [self.tblChatRoom reloadData];
        }
    }];
    
    [client connect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [chatList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Conversation *conversation = nil;
    NSInteger row = [indexPath row];
    
    if(nil != chatList && [chatList count] > 0) {
        conversation = [chatList objectAtIndex:row];
    }
    
    static NSString *cellIdentifierChatItemRcv = @"cellIdentifierChatItemRcv";
    ChatItemRcv *cellChatItemRcv = [self.tblChatRoom dequeueReusableCellWithIdentifier:cellIdentifierChatItemRcv];
    
    static NSString *cellIdentifierChatItemSent = @"cellIdentifierChatItemSent";
    ChatItemRcv *cellChatItemSent = [self.tblChatRoom dequeueReusableCellWithIdentifier:cellIdentifierChatItemSent];
    
    if([conversation isSent]) {
        cellChatItemSent.lblMessage.text = conversation.message;
        cellChatItemSent.lblNickName.text = conversation.username;
        
        return cellChatItemSent;
    } else {
        cellChatItemRcv.lblMessage.text = conversation.message;
        cellChatItemRcv.lblNickName.text = conversation.username;
        
        return cellChatItemRcv;
    }
}

#pragma mark - Table view delegate

- (IBAction)sendMessage:(id)sender {
    NSString *username = FAKE_USER_DATA;
    NSString *message = self.tfMessage.text;
    NSString *date = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username",
                           message, @"message", date, @"date", nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:URL_POST_MESSAGE parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tfMessage.text = @"";
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

@end
