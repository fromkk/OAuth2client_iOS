//
//  ViewController.m
//  Oauth2demo
//
//  Created by Kazuya Ueoka on 2015/11/13.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "UIAlertController+blocks.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Login";
    
    self.emailTextField = [[TMValidateTextField alloc] initWithRules:@[[TMValidatorRuleRequired rule], [TMValidatorRuleEmail rule]]];
    self.emailTextField.placeholder = @"email";
    self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailTextField.layer.borderColor = [UIColor redColor].CGColor;
    self.emailTextField.delegate = self;
    [self.view addSubview:self.emailTextField];
    
    self.passwordTextField = [[TMValidateTextField alloc] initWithRules:@[[TMValidatorRuleRequired rule], [TMValidatorRuleMinLength ruleWithLength:@4], [TMValidatorRuleMaxLength ruleWithLength:@16]]];
    self.passwordTextField.placeholder = @"password";
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.layer.borderColor = [UIColor redColor].CGColor;
    self.passwordTextField.delegate = self;
    self.passwordTextField.secureTextEntry = YES;
    [self.view addSubview:self.passwordTextField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loginButton addTarget:self action:@selector(loginButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.view addSubview:self.loginButton];
    
    self.skipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.skipButton addTarget:self action:@selector(skipButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.skipButton setTitle:@"skip" forState:UIControlStateNormal];
    [self.view addSubview:self.skipButton];
    
    [self checkValidate];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oauthClientStoreDidChangeNotification:) name:NXOAuth2AccountStoreAccountsDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oauthClientStoreDidFailToRequestAccessNotification:) name:NXOAuth2AccountStoreDidFailToRequestAccessNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.emailTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.emailTextField.frame = CGRectMake(10.0, 80.0, self.view.frame.size.width - 20.0, 44.0);
    self.passwordTextField.frame = CGRectMake(10.0, CGRectGetMaxY(self.emailTextField.frame) + 20.0, self.view.frame.size.width - 20.0, 44.0);
    
    self.loginButton.frame = CGRectMake((self.view.frame.size.width - 200.0) / 2.0, CGRectGetMaxY(self.passwordTextField.frame) + 60.0, 200.0, 44.0);
    self.skipButton.frame = CGRectMake((self.view.frame.size.width - 200.0), CGRectGetMaxY(self.loginButton.frame) + 40.0, 180.0f, 44.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkValidate
{
    self.loginButton.enabled = self.emailTextField.valid && self.passwordTextField.valid;
}


#pragma mark - loginButton did tapped

- (void)loginButtonDidTapped:(id)sender
{
    if (!self.emailTextField.valid || !self.passwordTextField.valid)
    {
        return;
    }

    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"famm" username:self.emailTextField.text password:self.passwordTextField.text];
}

#pragma mark - skipButton did tapped

- (void)skipButtonDidTapped:(id)sender
{
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:homeViewController animated:YES];
}

#pragma mark - textField text did change notification

- (void)textFieldDidChanged:(NSNotification *)notification
{
    TMValidateTextField *textField = notification.object;
    if (textField.valid)
    {
        textField.layer.borderWidth = 0.0;
    } else
    {
        textField.layer.borderWidth = 5.0;
    }
    
    [self checkValidate];
}

#pragma mark - textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - NXOAuth2ClientDelegate

- (void)oauthClientStoreDidChangeNotification:(NSNotification *)notif
{
    NXOAuth2Account *account = [[notif userInfo] objectForKey:NXOAuth2AccountStoreNewAccountUserInfoKey];
    [[NSUserDefaults standardUserDefaults] setObject:[account identifier] forKey:@"NXOAuth2AccountIdentifier"];
    if ( nil != account )
    {
        HomeViewController *homeViewController = [[HomeViewController alloc] init];
        [self.navigationController setViewControllers:@[homeViewController]];
    }
}

- (void)oauthClientStoreDidFailToRequestAccessNotification:(NSNotification *)notif
{
    NSLog(@"%s %@ %@", __func__, notif, [(NSError *)[notif.userInfo objectForKey:NXOAuth2AccountStoreErrorKey] localizedDescription]);
    [UIAlertController showAlertWithTitle:nil message:[(NSError *)[notif.userInfo objectForKey:NXOAuth2AccountStoreErrorKey] localizedDescription] viewController:self];
}

- (void)oauthClient:(NXOAuth2Client *)client didFailToGetAccessTokenWithError:(NSError *)error
{
    NSLog(@"%s %@ %@", __FUNCTION__, client, error);
}

- (void)oauthClientDidGetAccessToken:(NXOAuth2Client *)client
{
    NSLog(@"%s %@", __FUNCTION__, client);
}

- (void)oauthClientDidLoseAccessToken:(NXOAuth2Client *)client
{
    NSLog(@"%s %@", __FUNCTION__, client);
}

- (void)oauthClientDidRefreshAccessToken:(NXOAuth2Client *)client
{
    NSLog(@"%s %@", __FUNCTION__, client);
}

- (void)oauthClientNeedsAuthentication:(NXOAuth2Client *)client
{
    NSLog(@"%s %@", __FUNCTION__, client);
    NSURL *authorizationURL = [client authorizationURLWithRedirectURL:[NSURL URLWithString:OAuth_Redirect_URL]];
    NSLog(@"%@", authorizationURL);
    [[UIApplication sharedApplication] openURL:authorizationURL];
}

#pragma mark - dealloc


- (void)dealloc
{
    [self.emailTextField removeFromSuperview];
    self.emailTextField = nil;
    
    [self.passwordTextField removeFromSuperview];
    self.passwordTextField = nil;
    
    [self.loginButton removeFromSuperview];
    self.loginButton = nil;
}

@end
