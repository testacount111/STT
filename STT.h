

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <speex/speex.h>
#import "WaveView.h"

#define kNumberBuffers 3
#define kNumVolumeSamples 10
#define kSilenceThresholdDB -30.0

#define kVolumeSamplingInterval 0.05
#define kSilenceTimeThreshold 0.9
#define kSilenceThresholdNumSamples kSilenceTimeThreshold / kVolumeSamplingInterval

#define kMinVolumeSampleValue 0.01
#define kMaxVolumeSampleValue 1.0

#define kLang @"he-IL"

typedef struct AQRecorderState {
    AudioStreamBasicDescription  mDataFormat;                   
    AudioQueueRef                mQueue;                        
    AudioQueueBufferRef          mBuffers[kNumberBuffers];                    
    UInt32                       bufferByteSize;                
    SInt64                       mCurrentPacket;                
    bool                         mIsRunning;
    
    SpeexBits                    speex_bits; 
    void *                       speex_enc_state;
    int                          speex_samples_per_frame;
    __unsafe_unretained NSMutableData *              encodedSpeexData;
    
    __unsafe_unretained id selfRef;
} AQRecorderState;

@protocol STT <NSObject>

- (BOOL)didReceiveVoiceResponse:(NSData *)data;

@optional
- (void)showSineWaveView:(WaveView *)view;
-(void) updateWaveDisplay;
-(void) updateDataPoints :(NSArray *)dataPointsa ;
- (void)dismissSineWaveView:(WaveView *)view cancelled:(BOOL)wasCancelled;
- (void)showLoadingView;

@end

@interface STT : NSObject <UIAlertViewDelegate, SineWaveViewDelegate> {
    UIAlertView *status;
    
    AQRecorderState aqData;
    
    BOOL detectedSpeech;
    int samplesBelowSilence;
    
    NSTimer *meterTimer;
    BOOL processing;
    
    NSMutableArray *volumeDataPoints;
    WaveView *sineWave;
    
    NSThread *processingThread;
}

@property (readonly) BOOL recording;
@property (assign) id<STT> delegate;


- (id)initWithCustomDisplay:(NSString *)nibName;

- (void)beginRecording;


- (void)stopRecording:(BOOL)startProcessing;

@end
