#import "CommentView.h"

@implementation CommentView

- (void)setComment:(Comment *)comment
{
    UIColor *greyColor = [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:202.0/255.0 alpha:1];
    UIColor *gradientStartColor = [UIColor colorWithRed:247.0/255.0 green:248.0/255.0 blue:250.0/255.0 alpha:1];
    UIColor *gradientEndColor = [UIColor colorWithRed:209.0/255.0 green:212.0/255.0 blue:221.0/255.0 alpha:1];

    UIFont *headerFont = [UIFont fontWithName:@"Helvetica" size:14];
    UIFont *bodyFont = [UIFont fontWithName:@"Helvetica" size:14];

    NSInteger contentTextWidth = self.frame.size.width - (COMMENT_MARGIN * 2);

    CGSize headerTextSize = [comment.user.login sizeWithFont:headerFont constrainedToSize:CGSizeMake(contentTextWidth, 10000)];
    CGSize bodyTextSize = [comment.body sizeWithFont:bodyFont constrainedToSize:CGSizeMake(contentTextWidth, 10000)];
    CGSize headerSize = CGSizeMake(self.frame.size.width, headerTextSize.height + (COMMENT_MARGIN * 2));
    CGSize bodySize = CGSizeMake(self.frame.size.width, bodyTextSize.height + (COMMENT_MARGIN * 2) - 1);
    CGSize contentSize = CGSizeMake(self.frame.size.width, headerSize.height + bodySize.height);
    
    CGRect headerFrame = CGRectMake(0, 0, contentSize.width, headerSize.height);
    UIView *header = [[UIView alloc] initWithFrame:headerFrame];
    header.layer.borderColor = [greyColor CGColor];
    header.layer.borderWidth = 1;
    
    CAGradientLayer *gradient = [CAGradientLayer new];
    gradient.frame = header.bounds;
    gradient.colors = @[(id)[gradientStartColor CGColor], (id)[gradientEndColor CGColor]];
    [header.layer insertSublayer:gradient atIndex:0];
    
    CGRect headerTextFrame = CGRectMake(COMMENT_MARGIN, COMMENT_MARGIN, contentTextWidth, headerTextSize.height);
    UILabel *headerText = [[UILabel alloc] initWithFrame:headerTextFrame];
    headerText.text = comment.user.login;
    headerText.font = headerFont;
    headerText.backgroundColor = [UIColor clearColor];
    headerText.lineBreakMode = NSLineBreakByWordWrapping;
    headerText.numberOfLines = 0;
    
    UILabel *headerDate = [[UILabel alloc] initWithFrame:headerTextFrame];
    headerDate.textAlignment = NSTextAlignmentRight;
    headerDate.text = comment.createdAt.distanceOfTimeInWords;
    headerDate.font = headerFont;
    headerDate.backgroundColor = [UIColor clearColor];
    headerDate.lineBreakMode = NSLineBreakByWordWrapping;
    headerDate.numberOfLines = 0;
    
    CGRect bodyFrame = CGRectMake(0, headerSize.height - 1, bodySize.width, bodySize.height);
    UIView *body = [[UIView alloc] initWithFrame:bodyFrame];
    body.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1];
    body.layer.borderColor = [[UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:202.0/255.0 alpha:1] CGColor];
    body.layer.borderWidth = 1;
    
    CGRect bodyTextFrame = CGRectMake(COMMENT_MARGIN, COMMENT_MARGIN, contentTextWidth, bodyTextSize.height);
    UILabel *bodyText = [[UILabel alloc] initWithFrame:bodyTextFrame];
    bodyText.text = comment.body;
    bodyText.font = bodyFont;
    bodyText.backgroundColor = [UIColor clearColor];
    bodyText.lineBreakMode = NSLineBreakByWordWrapping;
    bodyText.numberOfLines = 0;
    
    [header addSubview:headerText];
    [header addSubview:headerDate];
    [body addSubview:bodyText];
    [self addSubview:header];
    [self addSubview:body];

    CGRect frame = self.frame;
    frame.size.height += headerFrame.size.height + bodyFrame.size.height;
    self.frame = frame;
}

@end
