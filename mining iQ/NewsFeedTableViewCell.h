//
//  NewsFeedTableViewCell.h
//  mining iQ
//
//  Created by Somnath on 07/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFeedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *newsDescriptionLbl;

@end
