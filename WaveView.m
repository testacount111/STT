

#import "WaveView.h"
#import "STT.h"

@interface WaveView ()

@property (retain) NSString *originalDoneText;

@end

@implementation WaveView

@synthesize delegate;
@synthesize points;
@synthesize backgroundView;
@synthesize waveDisplay;
@synthesize doneBtn;
@synthesize processingView;
@synthesize header;
@synthesize footer;
@synthesize originalDoneText;
@synthesize cancelBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    waveDisplay.points = self.points;
}

- (void)setDataPoints:(NSArray *)_dataPoints {
    [points release];
    points = [_dataPoints retain];
    waveDisplay.points = points;
}

- (void)dealloc {
    delegate = nil;
    [points release];
    [header release];
    [footer release];
    [backgroundView release];
    [waveDisplay release];
    [doneBtn release];
    [cancelBtn release];
    [processingView release];
    self.originalDoneText = nil;
    
    [super dealloc];
}

- (void)resetViewState {
    self.header.hidden = NO;
    self.header.text = @"Speak now";
    self.header.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    self.processingView.hidden = YES;
    self.waveDisplay.hidden = NO;
    self.doneBtn.hidden = NO;
    self.doneBtn.enabled = YES;
    self.cancelBtn.hidden = NO;
    self.footer.hidden = YES;
}

- (void)updateWaveDisplay {
    [waveDisplay setNeedsDisplay];
}

@end
