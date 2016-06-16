//
//  FFKPagedFormViewController.h
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKFormViewController.h"

@class FFKBarButtonItem;
@class FFKTableController;
@class FFKFieldset;

@interface FFKPagedFormView : UITableView <UIAppearance>

@property (nonatomic, strong) UILabel *headerLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UILabel *headerLabelColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *headerImageTintColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *validationErrorColor UI_APPEARANCE_SELECTOR;

@end

@interface FFKPagedFormViewController : FFKFormViewController

@property (readonly, strong) FFKPagedFormView *tableView;
@property (readonly, strong) FFKTableController *tableController;
@property (readonly, strong) FFKBarButtonItem *advancementBarButtonItem;
@property (readonly, strong) FFKBarButtonItem *advancementLongBarButtonItem;
@property (readonly, strong) FFKFieldset *fieldset;
@property (nonatomic, assign, getter=isPerformingTask) BOOL performingTask;
@property (readonly, strong) FFKInput *focusedInput;
@property (nonatomic, assign) BOOL focusInputOnViewDidAppear;

- (instancetype)initWithForm:(FFKForm *)form fieldset:(FFKFieldset *)fieldset;

@end

@interface _FFKPagedFormFauxNavigationBar : UIView

@property (nonatomic, strong) UIView *shadowView;

@end