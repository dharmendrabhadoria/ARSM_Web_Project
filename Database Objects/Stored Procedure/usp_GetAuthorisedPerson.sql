/*
SP Name       : usp_GetAuthorisedPerson
Purpose       : This stored procedure is used to get the Authorised Person of the pickup address.
Created By    : Rajendra Pawar
Creation Date : 18 July 2014
*/
If Exists (Select 1 From sysobjects Where Type = 'P' AND  name = 'usp_GetAuthorisedPerson')
Begin
	Drop Procedure usp_GetAuthorisedPerson
End
Go

Create Procedure usp_GetAuthorisedPerson 
(@n_PickupAddressId Int)    
As  
Begin  
 SET NOCOUNT ON  
 Select n_AuthorisedPersonId		As 'AuthorisedPersonId' ,	n_PickupAddressId	As  'PickupAddressId'
      ,s_AuthorisedPerson			As 'AuthorisedPerson'   ,	s_PhoneNumber		As  'PhoneNumber'
      ,s_Email						As 'Email'              ,   s_MobileNo			As  'MobileNo'
  From tbl_AuthorisedPersons
  Where n_PickupAddressId = @n_PickupAddressId
  Order by n_AuthorisedPersonId         
End  
Go