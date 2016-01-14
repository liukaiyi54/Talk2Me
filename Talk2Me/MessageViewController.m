//
//  MessageViewController.m
//  Talk2Me
//
//  Created by Michael on 15/11/21.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController () <JSQMessagesComposerTextViewPasteDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) UIButton *titleButton;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitleButton];

    self.senderId = @"Me";
    self.senderDisplayName = @"Honey";
    self.inputToolbar.contentView.textView.pasteDelegate = self;
    
    self.data = [[ModelData alloc] init];
    
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(delete:)];
    
    [self setupForDismissKeyboard];
}

#pragma mark - JSQMessagesViewController method overrides
- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date {
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    senderId = self.titleButton.titleLabel.text;
    
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:date text:text];
    
    [self.data.messages addObject:message];
    
    [self.data saveModelData];
    
    [self finishSendingMessageAnimated:YES];
}

- (void)didPressAccessoryButton:(UIButton *)sender {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Media messages" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Send photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *locationAction = [UIAlertAction actionWithTitle:@"Send location" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:photoAction];
    [ac addAction:locationAction];
    [ac addAction:cancelAction];
    
    [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark - JSQMessages CollectionView DataSource & Delegate

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.data.messages objectAtIndex:indexPath.item];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath {
    [self.data.messages removeObjectAtIndex:indexPath.item];
    [self.data saveModelData];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = [self.data.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.data.outgoingBubbleImageData;
    }
    
    return self.data.incomingBubbleImageData;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = [self.data.messages objectAtIndex:indexPath.item];
    
    return [self.data.avatars objectForKey:message.senderId];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.data.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *message = [self.data.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.data.messages objectAtIndex:indexPath.item - 1];
        if ([previousMessage.senderId isEqualToString:message.senderId]) {
            return nil;
        }
    }
    
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView shouldPasteWithSender:(id)sender {
    if ([UIPasteboard generalPasteboard].image) {
        JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIPasteboard generalPasteboard].image];
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:[NSDate date]
                                                             media:item];
        [self.data.messages addObject:message];
        [self finishSendingMessage];
        return NO;
    }
    return YES;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessage *currentMessage = [self.data.messages objectAtIndex:indexPath.item];
    if ([currentMessage.senderId isEqualToString:self.senderId]) {
        return 0.0f;
    }
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.data.messages objectAtIndex:indexPath.item - 1];
        if ([previousMessage.senderId isEqualToString:currentMessage.senderId]) {
            return 0.0f;
        }
    }
        
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

#pragma mark - UICollectionView DataSource & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data.messages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    JSQMessage *message = [self.data.messages objectAtIndex:indexPath.item];
    
    if (!message.isMediaMessage) {
        if ([message.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor whiteColor];
        } else {
            cell.textView.textColor = [UIColor blackColor];
        }
        
        cell.textView.linkTextAttributes = @{NSForegroundColorAttributeName: cell.textView.textColor,
                                             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)};
    }
    return cell;
}

#pragma mark - DismissKeyboard on touch screen
- (void)setupForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak typeof(self) weakSelf = self;
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

#pragma mark - private
- (void)setupTitleButton {
    self.titleButton = [[UIButton alloc] init];
    [self.titleButton setTitle:@"Honey" forState:UIControlStateNormal];
    [self.titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleButton addTarget:self action:@selector(didTapTitle:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.titleView = self.titleButton;
}

- (void)didTapTitle:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Honey"]) {
        [sender setTitle:@"Me" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"Honey" forState:UIControlStateNormal];
    }
}

@end
