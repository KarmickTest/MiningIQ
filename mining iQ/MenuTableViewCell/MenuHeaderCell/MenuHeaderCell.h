//
//  MenuHeaderCell.h
//  DarAlkitab
//
//  Created by Sayanta Bhowmick on 11/04/16.
//
//

#import <UIKit/UIKit.h>

@interface MenuHeaderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgVw_MenuHeader;
@property (strong, nonatomic) IBOutlet UILabel *lbl_UserName;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@end
