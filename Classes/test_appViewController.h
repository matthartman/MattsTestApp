//
//  test_appViewController.h
//  test-app
//
//  Copyright iPhoneDevTips.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface test_appViewController : UIViewController  <UINavigationControllerDelegate, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate> 
{
	UIButton *button;
}

@end

