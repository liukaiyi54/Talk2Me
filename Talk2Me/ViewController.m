//
//  ViewController.m
//  Talk2Me
//
//  Created by Michael on 15/11/17.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "MessageTextView.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation ViewController

- (id)init {
    self = [super initWithTableViewStyle:UITableViewStylePlain];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

+ (UITableViewStyle)tableViewStyleForCoder:(NSCoder *)decoder {
    return UITableViewStylePlain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < 10; i++) {
        Message *message = [Message new];
        message.userName = @"Michael";
        message.text = @"don't you miss me, i know you do";
        [array addObject:message];
    }
    
    NSArray *reversed = [[array reverseObjectEnumerator] allObjects];
    
    self.messages = [[NSMutableArray alloc] initWithArray:reversed];
    
    self.shakeToClearEnabled = YES;

//    self.textInputbar.maxCharCount = 256;
//    self.textInputbar.counterStyle = SLKCounterStyleSplit;
//    self.textInputbar.counterPosition = SLKCounterPositionTop;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (void)commonInit {
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:UIContentSizeCategoryDidChangeNotification object:nil];
    [self registerClassForTextView:[MessageTextView class]];
}
@end
