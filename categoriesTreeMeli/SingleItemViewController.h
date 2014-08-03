//
//  SingleItemViewController.h
//  categoriesTreeMeli
//
//  Created by usuario on 02/08/14.
//  Copyright (c) 2014 usuario. All rights reserved.
//

#import "ViewController.h"

@interface SingleItemViewController : UIViewController {
    IBOutlet UIScrollView *scroller;
    
}
@property (weak, nonatomic) IBOutlet UILabel *lblCurrency;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCondition;
@property (weak, nonatomic) IBOutlet UILabel *lblid;
@property (weak, nonatomic) IBOutlet UILabel *lblBuyingMode;
@property (weak, nonatomic) IBOutlet UIImageView *imagesView;

@property (strong, nonatomic) NSDictionary *itemSelected;

-(void) getImages;


@end
