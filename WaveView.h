

#import <UIKit/UIKit.h>
#import "Wave.h"

@protocol SineWaveViewDelegate <NSObject>

- (void)waveDoneAction;
- (void)waveCancelAction;

@end


@interface WaveView : UIViewController {
}

@property (assign) id<SineWaveViewDelegate> delegate;

@property (readonly)  Wave *waveDisplay;
@property (readonly)  UIImageView *backgroundView;
@property (readonly)  UIView *processingView;
@property (readonly)  UIButton *doneBtn;
@property (readonly)  UIButton *cancelBtn;
@property (readonly)  UILabel *header;
@property (readonly)  UITextView *footer;

@property (nonatomic, retain) NSArray *points;

- (void)updateWaveDisplay;

- (void)resetViewState;


@end
