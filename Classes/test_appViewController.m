//
//  test_appViewController.m
//  test-app
//
//  Copyright iPhoneDevTips.com All rights reserved.
//


#import "test_appViewController.h"

@implementation test_appViewController

- (void)emailImage:(UIImage *)image
{
  MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
  picker.mailComposeDelegate = self;

	// Set the subject of email
  [picker setSubject:@"Picture from my iPhone!"];

	// Add email addresses
  // Notice three sections: "to" "cc" and "bcc"	
	[picker setToRecipients:[NSArray arrayWithObjects:@"emailaddress1@domainName.com", @"emailaddress2@domainName.com", nil]];
	[picker setCcRecipients:[NSArray arrayWithObject:@"emailaddress3@domainName.com"]];	
	[picker setBccRecipients:[NSArray arrayWithObject:@"emailaddress4@domainName.com"]];

	// Fill out the email body text
	NSString *emailBody = @"I just took this picture, check it out.";

	// This is not an HTML formatted email
	[picker setMessageBody:emailBody isHTML:NO];

  // Create NSData object as PNG image data from camera image
  NSData *data = UIImagePNGRepresentation(image);
 	
	// Attach image data to the email
	// 'CameraImage.png' is the file name that will be attached to the email
	[picker addAttachmentData:data mimeType:@"image/png" fileName:@"CameraImage"];
	
	// Show email view	
	[self presentModalViewController:picker animated:YES];

	// Release picker
  [picker release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	[self dismissModalViewControllerAnimated:YES];
}

- (void)buttonPressed:(UIButton *)button
{
	// Create image picker controller
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  
  // Set source to the camera
	imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
  
  // Delegate is self
	imagePicker.delegate = self;
  
  // Allow editing of image ?
	imagePicker.allowsImageEditing = NO;
  
  // Show image picker
	[self presentModalViewController:imagePicker animated:YES];	
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// Access the uncropped image from info dictionary
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

	// Dismiss the camera
	[self dismissModalViewControllerAnimated:YES];

	// Pass the image from camera to method that will email the same
  // A delay is needed so camera view can be dismissed
  [self performSelector:@selector(emailImage:) withObject:image afterDelay:1.0];

	// Release picker
	[picker release];
}

- (id)init
{
  if (self = [super init]) 
  {
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
		self.view.backgroundColor = [UIColor grayColor];

    // Button to activate camera
    button = [[UIButton alloc] initWithFrame:CGRectMake(80, 55, 162, 53)];    
    [button setBackgroundImage:[UIImage imageNamed:@"Camera.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];      
    [self.view addSubview:button];
    [button release];
  }
  
  return self;  
}

- (void)dealloc 
{
  [super dealloc];
}

@end
