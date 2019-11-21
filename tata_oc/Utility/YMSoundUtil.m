//
//  YMSoundUtil.m
//  tata_oc
//
//  Created by Yongming on 2019/9/30.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMSoundUtil.h"
#import <AVFoundation/AVFoundation.h>

static const int MAX_VOLUMEVIEW_HEIGHT = 60;
#define kVolumeContainerColor [UIColor yellowColor]
static const float kVolumeViewWidth = 3;
static const float kVolumeViewGap = 2;
static const float kVolumeViewDefaultHeight = 4;
static const float kVolumeRange = 5;
static const float kCheckDataDuration = .5;
static const float kVolumeAnimationDuration = .6;

@interface YMVolumeItem : NSObject
@property (nonatomic, assign) int height;
@property (nonatomic, assign) BOOL isAnimated;
@end

@implementation YMVolumeItem
@end

@interface YMVolumeView : UIView
@property (nonatomic, strong)UIView* volumeView;
@end

@implementation YMVolumeView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(kVolumeViewGap, (self.height - kVolumeViewDefaultHeight)*.5, kVolumeViewWidth, kVolumeViewDefaultHeight)];
        [self addSubview:view];
        view.backgroundColor = [UIColor randomColor];
        self.volumeView = view;
    }
    return self;
}

@end

@interface YMSoundUtil()
@property (nonatomic, strong) AVAudioRecorder* recorder;
@property (nonatomic, strong) NSMutableArray* volumeViews;
@property (nonatomic, strong) NSMutableDictionary* volumeValueInfo;
@property (nonatomic, strong) NSTimer* levelTimer;
@property (nonatomic, strong) CADisplayLink* volumeUpdateTimer;
@end

@implementation YMSoundUtil

- (void)startCapturingOnView:(UIView *)view {
    
    if (!view) {
        
        if (!self.levelTimer) {
            
            [self addVolumeViews:view];
            self.levelTimer = [NSTimer scheduledTimerWithTimeInterval:kCheckDataDuration target: self selector: @selector(testTimerCallback) userInfo: nil repeats: YES];
        }
    }
    else {
        
        if (!self.recorder) {
            
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                             withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker | AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionAllowBluetooth
                                                   error:nil];
            /* 不需要保存录音文件 */
            NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
            
            NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                                      [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                      [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                      [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                                      nil];
            
            NSError *error;
            self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
            if (self.recorder)
            {
                [self.recorder prepareToRecord];
                self.recorder.meteringEnabled = YES;
                [self.recorder record];
                
                [self addVolumeViews:view];
                self.levelTimer = [NSTimer scheduledTimerWithTimeInterval:kCheckDataDuration target: self selector: @selector(levelTimerCallback) userInfo: nil repeats: YES];
                
//                self.volumeUpdateTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(levelTimerCallback)];
//                [self.volumeUpdateTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            }
            else
            {
                NSLog(@"%@", [error description]);
            }
        }
    }
}

- (void)stopCapturing {
    
    if (self.levelTimer) {
        [self.levelTimer invalidate];
        self.levelTimer = nil;
    }
    
    if (self.recorder) {
        [self.recorder stop];
        self.recorder = nil;
    }
    
    
    for (UIView* view in self.volumeViews) {
        [view.layer removeAllAnimations];
        [view removeFromSuperview];
    }
    [self.volumeViews removeAllObjects];
    [self.volumeValueInfo removeAllObjects];
}

- (void)addVolumeViews:(UIView*)parentView  {
    
    [self.volumeViews removeAllObjects];
    
    UIView* containerView = [[UIView alloc] init];
    [parentView addSubview:containerView];
    containerView.backgroundColor = kVolumeContainerColor;
    
    CGFloat rectangle = kVolumeViewWidth;
    CGFloat gap = kVolumeViewGap;
    CGFloat singleWidth = gap + rectangle + gap;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

    //MARK: FOR test
    CGFloat originalHeight = MAX_VOLUMEVIEW_HEIGHT;
    containerView.frame = CGRectMake(0, 300, screenWidth, originalHeight);
    
    int count = floor(screenWidth / singleWidth);
    int leaveOffset = (int)screenWidth % (int)singleWidth;
    CGFloat t = (CGFloat)leaveOffset / (CGFloat)count;
    singleWidth += t;
        
    for (int i = 0 ;i < count; i ++) {
        
        YMVolumeView* singleView = [[YMVolumeView alloc] initWithFrame:CGRectMake(i*singleWidth, 0, singleWidth, originalHeight)];
        [containerView addSubview:singleView];
        
        [self.volumeViews addObject:singleView];
    }
}

- (void)updateVolumeHeight:(int)volumeHeight {
    
    NSUInteger totalCount = self.volumeViews.count;
    int mid = arc4random() % totalCount;
    
    int range = kVolumeRange;
    
    mid = (mid <= range) ? range : mid;
    mid = (mid >= (totalCount - 1 - range)) ? (int)(totalCount - 1 - range) : mid;
    
    int min = mid - range;
    int max = mid + range + 1;
    
    // check animation item
//    for (int j = min; j < max; j ++) {
//        YMVolumeItem* item = [self.volumeValueInfo objectForKey:@(j)];
//        if (item && item.isAnimated) {
//            return;
//        }
//    }
    
    for (int j = min; j < max; j ++) {
        
        YMVolumeItem* item = [self.volumeValueInfo objectForKey:@(j)];
        if (!item) {
            item = [[YMVolumeItem alloc] init];
            [self.volumeValueInfo setObject:item forKey:@(j)];
        }
        
        int height = volumeHeight;
        if (j < mid) {
            height = (CGFloat)(j - min - 1) / (CGFloat)kVolumeRange * (CGFloat)volumeHeight;
        } else if (j > mid) {
            height = (CGFloat)(range - (j - mid) - 1) / (CGFloat)kVolumeRange * (CGFloat)volumeHeight;
        }
        
        height = (height < kVolumeViewDefaultHeight) ? kVolumeViewDefaultHeight : height;
        
        item.height = height;
        [self.volumeValueInfo setObject:item forKey:@(j)];
    }
}

- (void)testTimerCallback {
    
    int n = arc4random() % (int)MAX_VOLUMEVIEW_HEIGHT;
    
    [self updateVolumeHeight:n];
    
    [self drawVolumeView];
}


- (void)drawVolumeView {
    for (int i = 0; i < self.volumeViews.count; i ++) {
        YMVolumeView* volumeView = (YMVolumeView*)self.volumeViews[i];
        
        YMVolumeItem* item = [self.volumeValueInfo objectForKey:@(i)];
        if (!item) continue;
        
        int height = item.height;
        item.isAnimated = YES;
        [self.volumeValueInfo setObject:item forKey:@(i)];
        
        CGFloat y = (MAX_VOLUMEVIEW_HEIGHT - height) * .5;
        
        CGFloat duration = kVolumeAnimationDuration;//(CGFloat)(MAX_VOLUMEVIEW_HEIGHT - height) / (CGFloat)MAX_VOLUMEVIEW_HEIGHT;
        
        [UIView animateWithDuration:duration animations:^{
            volumeView.volumeView.height = height;
            volumeView.volumeView.y = y;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration animations:^{
                volumeView.volumeView.height = kVolumeViewDefaultHeight;
                volumeView.volumeView.y = (MAX_VOLUMEVIEW_HEIGHT - kVolumeViewDefaultHeight) * .5;
            } completion:^(BOOL finished) {
                item.isAnimated = NO;
                item.height = kVolumeViewDefaultHeight;
                [self.volumeValueInfo setObject:item forKey:@(i)];
            }];
        }];
    }
}

- (void)levelTimerCallback {
    
    [self.recorder updateMeters];
    
    float   level;                // The linear 0.0 .. 1.0 value we need.
    float   minDecibels = -60.0f; // use -80db Or use -60dB, which I measured in a silent room.
    float   decibels    = [self.recorder averagePowerForChannel:0];
    
    if (decibels < minDecibels)
    {
        level = 0.0f;
    }
    else if (decibels >= 0.0f)
    {
        level = 1.0f;
    }
    else
    {
        float   root            = 5.0f; //modified level from 2.0 to 5.0 is neast to real test
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        float   amp             = powf(10.0f, 0.05f * decibels);
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        
        level = powf(adjAmp, 1.0f / root);
    }
    
    int height = level * MAX_VOLUMEVIEW_HEIGHT;
    [self updateVolumeHeight:height];
    [self drawVolumeView];
}

- (NSMutableArray*)volumeViews {
    if (!_volumeViews) {
        _volumeViews = [NSMutableArray array];
    }
    return _volumeViews;
}

- (NSMutableDictionary*)volumeValueInfo {
    if (!_volumeValueInfo) {
        _volumeValueInfo = [NSMutableDictionary dictionary];
    }
    return _volumeValueInfo;
}

@end
