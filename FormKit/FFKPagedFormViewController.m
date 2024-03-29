//
//  FFKPagedFormViewController.m
//  FormKit
//
//  Created by Phillip Caudell on 02/06/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

#import "FFKPagedFormViewController.h"
#import "FormKit.h"
#import <TableKit/TableKit.h>

@interface FFKPagedFormViewController ()

@property (nonatomic, strong) _FFKPagedFormFauxNavigationBar *fauxNavigationBar;

- (void)presentFieldset:(FFKFieldset *)fieldset;

@end

@implementation FFKPagedFormViewController

- (instancetype)initWithForm:(FFKForm *)form
{
    if (self = [super initWithForm:form]) {
        _fieldset = form.fieldsets.firstObject;
    }
    
    return self;
}

- (instancetype)initWithForm:(FFKForm *)form fieldset:(FFKFieldset *)fieldset
{
    if (self = [super initWithForm:form]) {
        
        _fieldset = fieldset;
    }
    
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    _tableController = [[FFKTableController alloc] initWithTableView:self.tableView];
    
    _advancementBarButtonItem = [[FFKBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(handleAdvancement:)];
    self.navigationItem.rightBarButtonItem = self.advancementBarButtonItem;
    
    _advancementLongBarButtonItem = [[FFKBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(handleAdvancement:)];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[spaceItem, self.advancementLongBarButtonItem, spaceItem];
    
    [self applyStyles];
    
    [self.navigationController startAdjustingFrameToKeyboard];
    
    _fauxNavigationBar = [_FFKPagedFormFauxNavigationBar new];
    [self.view addSubview:self.fauxNavigationBar];
    
    __weak typeof(self) weakSelf = self;
    [self.tableController setTableViewDidScrollHandler:^(UITableView *tableView, CGPoint offset) {
        
        CGFloat alpha =  (offset.y / self.fauxNavigationBar.frame.size.height) + 1;
        weakSelf.fauxNavigationBar.alpha = alpha;
    }];
    
    [self presentFieldset:self.fieldset];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    FFKInput *firstInput = [self.fieldset.inputs firstObject];
    [self focusInput:firstInput animated:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.fauxNavigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
}

- (void)applyStyles
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundColor:[UIColor clearColor]];
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
    UIToolbar *toolbar = self.navigationController.toolbar;
    toolbar.barTintColor = [UIColor colorWithRed:1.00 green:0.59 blue:0.00 alpha:1.00];
    [toolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
    toolbar.tintColor = [UIColor whiteColor];
}

#pragma mark - Form methods

- (void)presentFieldset:(FFKFieldset *)fieldset
{
    _fieldset = fieldset;
    
    FFKTableRow *headerRow = [FFKTableRow tableRowWithConfigurationHandler:^(FFKTableRow *row) {
        row.text = fieldset.titleText;
        row.detailText = fieldset.detailText;
        row.cellClass = [FFKFeatureTableViewCell class];
        row.image = fieldset.image;
        [row setCellConfigurationHandler:^(FFKTableRow *row, FFKInputTableViewCell *cell) {
            cell.seperatorsHidden = YES;
        }];
    }];
    
    FFKTableSection *headerSection = [FFKTableSection tableSectionWithConfigurationHandler:^(FFKTableSection *section) {
        section.rows = @[headerRow];
    }];
    
    NSArray *inputRows = [fieldset.inputs mapObjectsUsingBlock:^id(FFKInput *input, NSInteger idx) {
        return [FFKTableRow tableRowWithConfigurationHandler:^(FFKTableRow *row) {
            
            row.cellClass = input.viewCellClass;
            
            // In an ideal world, I think I would have sublassed an input from a row. OH WELL
            row.context = input;
            input.row = row;
            
            if (input.isCheckable) {
                row.height = 80;
            } else {
                row.height = 60;
            }
    
            [row setCellConfigurationHandler:^(FFKTableRow *row, FFKInputTableViewCell *cell) {
                [input configureView:cell];
                cell.textLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
            }];
            
            [row setInteractionHandler:^(FFKTableInteraction *interaction) {

                // Whole cell tapped
                if (interaction.type == FFKTableInteractionTypePrimary) {
                    
                    if (input.isFocusable) {
                        [self focusInput:input animated:YES];
                    }
                    
                    if (input.isCheckable) {
                        [self checkInput:input animated:YES];
                    }
                }
                
                // If the detail button is pressed, it has a validation warnng...
                if (interaction.type == FFKTableInteractionTypeSecondary) {
                    
                    FFKInput *input = interaction.row.context;
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:input.validatorError.localizedDescription message:input.validatorError.localizedRecoverySuggestion preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }];
        }];
    }];
    
    FFKTableSection *inputSection = [FFKTableSection tableSectionWithConfigurationHandler:^(FFKTableSection *section) {
        section.headerText = fieldset.hintText;
        section.rows = inputRows;
    }];
    
    self.tableController.tableSections = @[headerSection, inputSection];
    
    [self.tableView reloadData];
}

- (void)focusInput:(FFKInput *)input animated:(BOOL)animated
{
    if (!self.fieldset) {
        return;
    }
    
    NSIndexPath *inputIndexPath = [NSIndexPath indexPathForRow:[self.fieldset.inputs indexOfObject:input] inSection:1];
    FFKInputTableViewCell *cell = [self.tableView cellForRowAtIndexPath:inputIndexPath];
    [cell focus];
    
    [self.tableView deselectRowAtIndexPath:inputIndexPath animated:YES];
    [self.tableView scrollToRowAtIndexPath:inputIndexPath atScrollPosition:UITableViewScrollPositionNone animated:animated];

    // If the previous input was a text field, but we don't require keyboard anymore, dismiss it
    if ([self.focusedInput isKindOfClass:[FFKTextInput class]]) {
        
        NSIndexPath *previousInputIndexPath = [NSIndexPath indexPathForRow:[self.fieldset.inputs indexOfObject:self.focusedInput] inSection:1];
        FFKTextInputTableViewCell *cell = [self.tableView cellForRowAtIndexPath:previousInputIndexPath];
        [cell defocus];
    }
    
    [self willChangeValueForKey:@"focusedInput"];
    _focusedInput = input;
    [self didChangeValueForKey:@"focusedInput"];
    
    [self.tableController reloadDirtyRowsWithAnimation:UITableViewRowAnimationAutomatic];
}

- (void)checkInput:(FFKInput *)input animated:(BOOL)animated
{
    NSIndexPath *inputIndexPath = [NSIndexPath indexPathForRow:[self.fieldset.inputs indexOfObject:input] inSection:1];
    FFKInputTableViewCell *cell = [self.tableView cellForRowAtIndexPath:inputIndexPath];
    
    if ([input.value isEqualToNumber:@(1)]) {
        [cell uncheck];
    } else {
        [cell check];
    }
    
    [self.tableView deselectRowAtIndexPath:inputIndexPath animated:YES];
}

- (FFKInput *)nextInput
{
    NSInteger currentIndex = [self.fieldset.inputs indexOfObject:self.focusedInput];
    NSInteger nextIndex = currentIndex + 1;
    
    if (nextIndex < self.fieldset.inputs.count) {
        return self.fieldset.inputs[nextIndex];
    }
    
    return nil;
}

- (FFKInput *)nextFocusableInput
{
    NSInteger currentIndex = [self.fieldset.inputs indexOfObject:self.focusedInput];
    
    for (NSInteger i = currentIndex + 1; i < self.fieldset.inputs.count; i++) {

        FFKInput *input = self.fieldset.inputs[i];
        if (input.isFocusable) {
            return input;
        }
    }
    
    return nil;
}

- (void)setPerformingTask:(BOOL)performingTask
{
    [self willChangeValueForKey:@"performingTask"];
    
    _performingTask = performingTask;
    
    if (performingTask) {
        self.tableView.userInteractionEnabled = NO;
        [self.advancementBarButtonItem startActivityAnimating];
        [self.advancementLongBarButtonItem startActivityAnimating];
    } else {
        self.tableView.userInteractionEnabled = YES;
        [self.advancementLongBarButtonItem stopActivityAnimating];
        [self.advancementLongBarButtonItem stopActivityAnimating];
    }
    
    [self didChangeValueForKey:@"performingTask"];
}

#pragma mark - Action Handlers

- (void)handleAdvancement:(id)sender
{
    // First, are there any inputs?
    if ([self nextFocusableInput]) {
        return [self focusInput:[self nextFocusableInput] animated:YES];
    }
    
    // Check for validation issues
    if (self.fieldset.inputsContainValidatorErrors) {
        return [self presentValidatorErrors];
    }

    // If we have custom handler on the fieldset, use that
    if (self.fieldset.advancementHandler) {
        
        // Update UI for potentially async task...
        self.performingTask = YES;
        
        FFKFieldsetAdvancementCallback callback = ^(FFKFieldset *fieldset) {
            
            self.performingTask = NO;
            
            FFKPagedFormViewController *viewController = [[FFKPagedFormViewController alloc] initWithForm:self.form fieldset:fieldset];
            [self.navigationController pushViewController:viewController animated:YES];
        };
        
        self.fieldset.advancementHandler(self.fieldset, callback);
        
    } else {
        
        // If not default behaviour is to go to next logical fieldset
        
        NSInteger currentIndex = [self.form.fieldsets indexOfObject:self.fieldset];
        NSInteger nextIndex = currentIndex + 1;
        
        if (nextIndex < self.form.fieldsets.count) {
            
            FFKFieldset *nextFieldset = self.form.fieldsets[nextIndex];
            FFKPagedFormViewController *viewController = [[FFKPagedFormViewController alloc] initWithForm:self.form fieldset:nextFieldset];
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else {
            NSLog(@"---- End of form. Do something here");
        }
        
    }
}

- (void)presentValidatorErrors
{
    [self.tableController reloadDirtyRowsWithAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Keyboard

- (void)willHideKeyboard:(NSNotification *)notification
{
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, 0, 0);
}

- (void)willShowKeyboard:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, keyboardFrame.size.height + 44, 0);
}

@end

@implementation _FFKPagedFormFauxNavigationBar

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
        self.shadowView = [UIView new];
        self.shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
        [self addSubview:self.shadowView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    self.shadowView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 0.5);
}

@end
