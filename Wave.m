

#import "Wave.h"
#import "STT.h"

@implementation Wave

@synthesize points;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    self.points = nil;
    
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    static bool reverse = false;
    
    CGFloat scaleFactor = ((rect.size.height / 2) - 4.0) / kMaxVolumeSampleValue;

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextSetRGBStrokeColor(context,0.5, 0.2, 0.2, 1.0);
    CGContextSetLineWidth(context, 0.5);
    int count = [self.points count];
    CGFloat dx = rect.size.width / count;
    CGFloat x = 0.0;
    CGFloat y = rect.size.height / 2;
    CGContextMoveToPoint(context, x, y);
    BOOL down = NO;
    
    for (NSNumber *point in self.points) {
        CGFloat raw = [point floatValue] * scaleFactor;
        CGFloat draw = (down ? -raw : raw);
        draw = (reverse ? -draw : draw);
        CGContextAddQuadCurveToPoint(context, x + dx/2, y - draw * 2, x += dx, y);
        
        down = !down;
    }
    reverse = !reverse;
    CGContextDrawPath(context, kCGPathStroke);
}

@end
