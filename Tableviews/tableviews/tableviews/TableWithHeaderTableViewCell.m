//
//  Created by Luis on 10/27/15.
//  Copyright © 2015 lc. All rights reserved.
//

#import "TableWithHeaderTableViewCell.h"

@implementation TableWithHeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(Place *)currentPlace
{
    current                 = currentPlace;
    _titleLabel.text        = currentPlace.getTitle;
    _descriptionLabel.text  = currentPlace.getDescription;
    _image.image            = [UIImage imageNamed:currentPlace.getImage];
}

@end
