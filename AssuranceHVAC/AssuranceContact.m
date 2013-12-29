//
//  AssuranceContact.m
//  AssuranceHVAC
//
//  Created by Cory Ginsberg on 8/9/13.
//  Copyright (c) 2013 Any Apps R Us. All rights reserved.
//

#define StringFromBOOL(b) ((b) ? @"YES" : @"NO")

#import "AssuranceContact.h"
@implementation AssuranceContact

+(BOOL)isContactCreated
{
    CFErrorRef err = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(nil, &err);
    
    ABAddressBookRequestAccessWithCompletion(addressBook,
                                             ^(bool granted, CFErrorRef error) {
                                             });
    
    ABAuthorizationStatus stat = ABAddressBookGetAuthorizationStatus();
    if (stat==kABAuthorizationStatusDenied ||
        stat==kABAuthorizationStatusRestricted) {
        UIAlertView *accessDenideAlert = [[UIAlertView alloc] initWithTitle:@"Access Denided" message:@"This app does not have access to your contacts. Please go to Settings>Privacy>Contacts to make sure this app is allowed to view your contacts and try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [accessDenideAlert show];
    }
    
	// Fetch the address book
	// Search for the company named "Assurance Heating & Air Conditioning" in the address book
	NSArray *people = (NSArray *)CFBridgingRelease(ABAddressBookCopyPeopleWithName(addressBook, CFSTR("Assurance Heating & Air Conditioning")));
	CFRelease(addressBook);
    //NSLog(@"Is Contact Created?");
    //NSLog(StringFromBOOL((people != nil) && [people count]));
    return (people != nil) && [people count];
}

-(void)createContact {
    
    CFErrorRef error = NULL;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error); // create address book record
    ABAddressBookRequestAccessWithCompletion(addressBook, nil);
    
    NSLog(@"%@", addressBook);
    ABRecordRef office = ABPersonCreate(); // create a person
    
    ABRecordSetValue(office, kABPersonOrganizationProperty, @"Assurance Heating & Air Conditioning", nil);
    
    // create new email-ref
    ABMutableMultiValueRef email = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    // set the work mail
    ABMultiValueAddValueAndLabel(email, @"assurhvac@aol.com", kABWorkLabel, NULL);
    // add the mail to person
    ABRecordSetValue(office, kABPersonEmailProperty, email, &error);
    // release mail object
    CFRelease(email);
    
    //Create the Company Logo
    UIImage *image = [UIImage imageNamed:@"assuranceLogo@2x"];
    NSData *dataRef = UIImagePNGRepresentation(image);
    CFDataRef cfdata = CFDataCreate(NULL, [dataRef bytes], [dataRef length]);
    ABPersonSetImageData(office, cfdata, &error);
    
    //Phone number is a list of phone number, so create a multivalue
    ABMultiValueRef phoneNum = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phoneNum, @"(847)729-4328", kABPersonPhoneMainLabel, NULL);
    ABMultiValueAddValueAndLabel(phoneNum, @"(847)729-7301", kABPersonPhoneWorkFAXLabel, NULL);
    ABRecordSetValue(office, kABPersonPhoneProperty, phoneNum, &error);
    
    // create address object
    ABMutableMultiValueRef address = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
    // create a new dictionary
    NSMutableDictionary *addressDict = [[NSMutableDictionary alloc] init];
    // set the address line to new dictionary object
    addressDict[(NSString *) kABPersonAddressStreetKey] = @"1953 Johns Dr";
    // set the city to new dictionary object
    addressDict[(NSString *)kABPersonAddressCityKey] = @"Glenview";
    // set the state to new dictionary object
    addressDict[(NSString *)kABPersonAddressStateKey] = @"Illinois";
    // set the zip/pin to new dictionary object
    addressDict[(NSString *)kABPersonAddressZIPKey] = @"60025";
    // set the country to new dictionary object
    addressDict[(NSString *)kABPersonAddressCountryCodeKey] = @"US";
    // retain the dictionary
    CFTypeRef ctr = CFBridgingRetain(addressDict);
    // copy all key-values from ctr to Address object
    ABMultiValueAddValueAndLabel(address,ctr, kABWorkLabel, NULL);
    // add address object to person
    ABRecordSetValue(office, kABPersonAddressProperty, address, &error);
    
    ABRecordSetValue(office, kABPersonNoteProperty, @"Office Hours:\nMon-Fri: 8am - 5pm\n24/7 Emergency Service", &error);
    ABAddressBookAddRecord(addressBook, office, &error); //add the new person to the record
    ABAddressBookSave(addressBook, &error);
    CFRelease(addressBook);
    CFRelease(office);
    CFRelease(phoneNum);
    CFRelease(address);
    CFRelease((__bridge CFTypeRef)(addressDict));
    
    if (error) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error has occurred while trying to save our contact. Please try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
    } else {
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Our contact has successfully been saved. To view our contact, go into the Contacts app and search \"Assurance\"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [successAlert show];
    }
    CFRelease(cfdata);
}

@end
