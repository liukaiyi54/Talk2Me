//
//  ModelData.h
//  Talk2Me
//
//  Created by Michael on 15/11/21.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSQMessages.h"

static NSString * const kJSQDemoAvatarDisplayNameJobs = @"Jobs";

static NSString * const kJSQDemoAvatarIdJobs = @"707-8956784-57";

@interface ModelData : NSObject

@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSDictionary *avatars;
@property (nonatomic, strong) JSQMessagesBubbleImage *outgoingBubbleImageData;
@property (nonatomic, strong) JSQMessagesBubbleImage *incomingBubbleImageData;
@property (nonatomic, strong) NSDictionary *users;

- (void)addPhotoMediaMessage;
- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion;

- (void)saveModelData;

@end
