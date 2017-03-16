//
//  AudioPlayerTextMangager.m
//  JusAuto
//
//  Created by ju on 2017/2/17.
//  Copyright © 2017年 ju. All rights reserved.
//

#import "AudioPlayerTextMangager.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface AudioPlayerTextMangager()<AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@end

@implementation AudioPlayerTextMangager
+ (instancetype)sharedInstance
{
    static AudioPlayerTextMangager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!instance)
        {
            instance = [[AudioPlayerTextMangager alloc] init];
        }
    });
    return instance;
}

- (void)audioPlayer:(NSString *)aText
{
    if( [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0)
    {
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:aText];
//        utterance.rate *= 0.8;
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate;
        AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];   
        synth.delegate = self; 
        self.synthesizer = synth;
        
//        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord  
//                                         withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
//                                               error:nil];
        //获取当前系统语音
        NSString *currentLang = @"zh-Hans";//[PublicUtil LanguageGetUserLanguage];
        NSString *preferredLang = @"";
        if ([currentLang isEqualToString:@"zh-Hans"] || [currentLang length] == 0)
        {
            preferredLang = @"zh-CN";
        }
        else
        {
            preferredLang = @"en-US";
        }
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[NSString stringWithFormat:@"%@",preferredLang]];
        utterance.voice = voice;
        [synth speakUtterance:utterance];
    }
}

- (void)audioSession
{
    //在后台播放，听筒
    NSError *error = NULL;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if(error) {
        // Do some error handling
    }
    if (error) {
        // Do some error handling
    }
}

- (void)audioStop
{
    [self stopSynthesizer:self.synthesizer];
    self.isStop = YES;

}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(textPlayerFinised)])
    {
        [self.delegate textPlayerFinised];
    }
}

- (void)stopSynthesizer:(AVSpeechSynthesizer *)aSynthesizer
{
    if([aSynthesizer isSpeaking]) {
        NSLog(@"Reading has been stopped");
        [aSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@""];
        [aSynthesizer speakUtterance:utterance];
        [aSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}
@end
