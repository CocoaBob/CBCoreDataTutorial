//
//  MCViewController.m
//  TestCoreData
//
//  Created by CocoaBob on 24/04/2014.
//  Copyright (c) 2014 CocoaBob. All rights reserved.
//

#import "MCViewController.h"

@interface MCViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSArray *histories;

@end

@implementation MCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // Table View
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view = self.tableView;

    // Text Field
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 123, 32)];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.backgroundColor = [UIColor grayColor];
    _textField.delegate = self;

    NSMutableParagraphStyle *paraphStyle = [NSMutableParagraphStyle new];
    paraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *textAttributes = @{NSParagraphStyleAttributeName:paraphStyle,
                                     NSForegroundColorAttributeName:[UIColor whiteColor]};

    _textField.defaultTextAttributes = textAttributes;
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Type here...", nil)
                                                                       attributes:textAttributes];

    _tableView.tableHeaderView = _textField;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"Demo %d",indexPath.row];

    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [_textField resignFirstResponder];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
