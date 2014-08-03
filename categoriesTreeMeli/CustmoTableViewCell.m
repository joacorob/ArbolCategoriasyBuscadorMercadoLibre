//
//  CustmoTableViewCell.m
//  categoriesTreeMeli
//
//  Created by usuario on 02/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "CustmoTableViewCell.h"

@implementation CustmoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
