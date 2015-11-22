//
//  MessageViewController.h
//  Talk2Me
//
//  Created by Michael on 15/11/21.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQMessages.h"
#import "ModelData.h"

@interface MessageViewController : JSQMessagesViewController

@property (nonatomic, strong) ModelData *data;

@end
