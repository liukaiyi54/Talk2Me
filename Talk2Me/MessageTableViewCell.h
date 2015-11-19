//
//  MessageTableViewCell.h
//  Talk2Me
//
//  Created by Michael on 15/11/18.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bodyLabel;
@property (nonatomic, strong) UIImageView *thumbnailView;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (CGFloat)defaultFontSize;

@end
