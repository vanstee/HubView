//
//  HVTextFieldCell.m
//  HubView
//
//  Created by ADML on 2012-12-30.
//  Copyright (c) 2012 Patrick Van Stee. All rights reserved.
//

#import "HVTextFieldCell.h"

#define HVTEXTFIELDCELL_LEFTMARGIN 125
#define HVTEXTFIELDCELL_HEIGHT 27

@implementation HVTextFieldCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.text = @"Prompt";
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(HVTEXTFIELDCELL_LEFTMARGIN, 9, self.contentView.frame.size.width - HVTEXTFIELDCELL_LEFTMARGIN, HVTEXTFIELDCELL_HEIGHT)];
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textField.textColor = self.detailTextLabel.textColor;
        [self.contentView addSubview:self.textField];
    }
    
    return self;
}

@end