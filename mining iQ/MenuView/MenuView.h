//
//  MenuView.h
//  DarAlkitab
//
//  Created by Sayanta Bhowmick on 08/04/16.
//
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate <NSObject>
@required
- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer;
- (CGFloat)contentViewMinX;
- (void)drawerMenuOpenClose;
@optional
-(void)TaponcellWithIndex:(NSInteger)Index WithTitle:(NSString *)Title;

@end
@interface MenuView : UIView<UITableViewDataSource,UITableViewDelegate>
typedef NS_ENUM(NSUInteger, NVSlideMenuControllerSlideDirection400)
{
    NVSlideMenuControllerSlideFromLeftToRight21,  // default, slide from left to right to open the menu
    NVSlideMenuControllerSlideFromRightToLeft21 =0// slide from right to left to open the menu
};
@property (nonatomic, strong) UITableView *tblVw_Menu;
@property (nonatomic, weak) id<MenuViewDelegate>DelegateMenu;
@property (nonatomic, assign) NVSlideMenuControllerSlideDirection400 slideDirection;
@property (nonatomic, assign) BOOL menuWasOpenAtPanBegin;
@property (nonatomic, assign, getter = isContentViewHidden) BOOL contentViewHidden;
@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, assign) BOOL isMenuopen;
@property (nonatomic, assign) CGRect objMenuViewFrame;
//@property (nonatomic, strong) UIView *vw_TableHeader;
//@property (nonatomic, strong) UILabel *lbl_UserName;
@end
