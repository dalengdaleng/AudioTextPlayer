//
//  AudioPlayerTextMangager.h
//  JusAuto
//
//  Created by ju on 2017/2/17.
//  Copyright © 2017年 ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AudioTextPlayerProtocol <NSObject>

- (void)textPlayerFinised;

@end

@interface AudioPlayerTextMangager : NSObject
@property (nonatomic, weak) id<AudioTextPlayerProtocol>delegate;
@property (nonatomic, assign) BOOL isStop;

+ (instancetype)sharedInstance;
- (void)audioPlayer:(NSString *)aText;
- (void)audioSession;

- (void)audioStop;
@end
