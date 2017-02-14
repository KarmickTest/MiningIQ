//
//  DropDownTableViewCell.h
//  mining iQ
//
//  Created by Somnath on 08/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headingNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UIImageView *sideImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
