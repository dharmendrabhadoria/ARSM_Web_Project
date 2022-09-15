/*
SP Name: tr_RateCard
Description: This Trigger is used to keep Audit of tbl_RateCard.  
Created By:  Vipul More
Creation Date: 07 July 2014
*/
If Exists (Select 1 From sys.triggers Where  Name = 'tr_RateCard') 
Begin
   Drop Trigger tr_RateCard
End 
Go

Create Trigger tr_RateCard
 	On tbl_RateCard After Update
As
Begin
 	Insert Into tbl_AuditRateCard
 		(n_RateCardId,		n_CustomerId,		n_ActivityId,
		 n_Rate,			d_ModifiedDate,		n_UserId) 
 	Select	n_RateCardId,	n_CustomerId,		n_ActivityId,
			n_Rate,			GETDATE(),			n_UserId		 			
	From Deleted
End

