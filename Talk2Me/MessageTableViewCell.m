//
//  MessageTableViewCell.m
//  Talk2Me
//
//  Created by Michael on 15/11/18.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "SLKTextView+SLKAdditions.h"

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}

- (void)configureSubviews {
    [self.contentView addSubview:self.thumbnailView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bodyLabel];
    

}

@end
