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
        [self loadMessages];
        
        JSQMessagesAvatarImage *myImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"me"] diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        JSQMessagesAvatarImage *honeyImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"pretty"] diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        self.avatars = @{@"Me": myImage, @"Honey": honeyImage};
        
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleBlueColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
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

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

- (NSString *)dataFilePath {
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Talk2Me.plist"];
}

- (void)saveModelData {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.messages forKey:@"messages"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadMessages {
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.messages = [unarchiver decodeObjectForKey:@"messages"];
        [unarchiver finishDecoding];
    } else {
        self.messages = [[NSMutableArray alloc] init];
    }
}

@end
