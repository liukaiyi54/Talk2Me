//
//  ModelData.m
//  Talk2Me
//
//  Created by Michael on 15/11/21.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "ModelData.h"

@implementation ModelData

- (instancetype)init {
    self = [super init];
    if (self) {
        self.messages = [NSMutableArray new];
        
        JSQMessagesAvatarImage *jobsImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_jobs"] diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        self.avatars = @{kJSQDemoAvatarIdJobs: jobsImage};
        
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleBlueColor]];
    }
    return self;
}

- (void)addPhotoMediaMessage {
    JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage imageNamed:@""]];
    JSQMessage *photoMessage = [JSQMessage messageWithSenderId:@"123" displayName:@"asdf" media:photoItem];
    
    [self.messages addObject:photoMessage];
}

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion {
    
}

@end
