#import "CommitMessageView.h"

#import <QuartzCore/QuartzCore.h>

@implementation CommitMessageView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.layer.backgroundColor = [UIColor commitMessageViewBackgroundColor].CGColor;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor commitMessageViewBorderColor].CGColor;
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 0;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
    }

    return self;
}

- (void)setCommitMessage:(NSString *)commitMessage
{
    _commitMessage = commitMessage;

    NSString *subject = @"";
    NSString *body = @"";

    NSString *rangeRegex = @"\\A(.[^\n]{0,49})(.*)\\z";
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:rangeRegex options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionAnchorsMatchLines error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:commitMessage options:0 range:NSMakeRange(0, commitMessage.length)];

    for (int index = 1; index < match.numberOfRanges; index++) {
        NSRange range = [match rangeAtIndex:index];

        if (NSEqualRanges(range, NSMakeRange(NSNotFound, 0))) { continue; }

        NSString *capture = [commitMessage substringWithRange:range];

        switch (index) {
            case 1: subject = capture; break;
            case 2: body    = capture; break;
            default: break;
        }
    }

    if (body.length && [body rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]].location != NSNotFound) {
        body = [body stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    }

    UIFont *subjectFont = [UIFont fontWithName:@"Helvetica" size:24];
    UIFont *bodyFont = [UIFont fontWithName:@"Menlo" size:16];

    CGSize subjectSize = [subject sizeWithFont:subjectFont constrainedToSize:CGSizeMake(self.frame.size.width, 500) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize bodySize = [body sizeWithFont:bodyFont constrainedToSize:CGSizeMake(self.frame.size.width, 500) lineBreakMode:NSLineBreakByWordWrapping];

    CGRect subjectFrame = CGRectMake(COMMIT_MESSAGE_PADDING, COMMIT_MESSAGE_PADDING,  self.frame.size.width - (COMMIT_MESSAGE_PADDING * 2), subjectSize.height);
    CGRect bodyFrame = CGRectMake(COMMIT_MESSAGE_PADDING, (COMMIT_MESSAGE_PADDING / 2.0) + subjectSize.height + COMMIT_MESSAGE_PADDING, self.frame.size.width - (COMMIT_MESSAGE_PADDING * 2), bodySize.height);

    UILabel *subjectLabel = [[UILabel alloc] initWithFrame:subjectFrame];
    subjectLabel.font = subjectFont;
    subjectLabel.textColor = [UIColor commitMessageFontColor];
    subjectLabel.lineBreakMode = NSLineBreakByWordWrapping;
    subjectLabel.numberOfLines = 0;
    subjectLabel.backgroundColor = [UIColor clearColor];
    subjectLabel.text = subject;
    [self addSubview:subjectLabel];

    if (![body isEqualToString:@""]) {
        UILabel *bodyLabel = [[UILabel alloc] initWithFrame:bodyFrame];
        bodyLabel.font = bodyFont;
        bodyLabel.textColor = [UIColor commitMessageFontColor];
        bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        bodyLabel.numberOfLines = 0;
        bodyLabel.backgroundColor = [UIColor clearColor];
        bodyLabel.text = body;
        [self addSubview:bodyLabel];
    }

    CGRect frame = self.frame;
    frame.size.height = COMMIT_MESSAGE_PADDING + subjectSize.height;
    if (![body isEqualToString:@""]) { frame.size.height += (COMMIT_MESSAGE_PADDING / 2.0) + bodySize.height; }
    frame.size.height += COMMIT_MESSAGE_PADDING;
    self.frame = frame;
}

@end
