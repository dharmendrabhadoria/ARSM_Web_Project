
delete from S_Company_Master where Created_By in(5162)
delete from S_Contact_Master where Created_By in(5162)
delete from S_Lead_Master where Created_By in(5162)
delete from S_Event_Master where Created_By in(5162)
delete from S_Enquiry_Master where Created_By in(5162) 
--Delete S_Enquiry_Hotel_Detail
--Delete S_Quotation_Hotel_Details
--Delete S_Invoice_Hotel_Details
--Delete S_Payment_Master

--delete from S_Invoice_Master where Created_By =2088 

--delete from  S_Invoice_Items where Created_By =2088 


---LI -75 AND QI 72
SELECT * FROM S_Enquiry_Master ORDER BY Enquiry_ID DESC

SELECT * FROM S_Enquiry_Hotel_Detail  ORDER BY Enquiry_Hotel_Detail_ID DESC

SELECT * FROM S_Enquiry_Tour_Detail ORDER BY Enquiry_Tour_Detail_ID DESC

SELECT * FROM s_RoomDetails ORDER BY RoomDetailID DESC

SELECT * FROM S_Enquiry_Tour_RoomCostDetails ORDER BY RoomCostDetailsID DESC

--Delete S_Enquiry_Tour_Detail where Created_By in(5162)
--Delete S_Additional_Services where Created_By in(5162)
--Delete S_Additional_Charges where Created_By in(5162)
--Delete S_Enquiry_Tour_Room_Detail where Created_By in(5162)
--Delete S_Enquiry_Tour_Itinerary_Detail where Created_By in(5162)
--Delete S_Enquiry_Tour_Itinerary_By_Operation where Created_By in(5162)
--Delete S_Enquiry_Tour_CostDetails where CreatedBy in(5162)
--Delete S_Enquiry_Tour_RoomCostDetails

Delete S_Enquiry_Tour_Detail
Delete S_Enquiry_Tour_Room_Detail
Delete S_Enquiry_Tour_Itinerary_Detail
Delete S_Enquiry_Tour_Itinerary_By_Operation
Delete S_Enquiry_Tour_CostDetails
Delete S_Additional_Services
Delete s_RoomDetails
Delete S_Invoice_Tour_Details
Delete S_Invoice_Tour_Itinerary_Detail
Delete S_Invoice_Tour_Room_Detail
Delete S_Invoice_Tax_Details


SELECT * FROM  S_Quotation_Master where Created_By in(5162) 
SELECT * FROM  S_Quotation_Items where Created_By in(5162) 
SELECT * FROM  S_Quotation_Tour_Details where Created_By in(5162)
SELECT * FROM  S_Quotation_Tour_Cost_Details where CreatedBy in(5162)
SELECT * FROM  S_Quotation_Tour_Room_Details where CreatedBy in(5162)

delete from  S_Quotation_Master where Created_By in(5162) 
delete from  S_Quotation_Items where Created_By in(5162) 
delete from  S_Quotation_Tour_Details where Created_By in(5162)
delete from  S_Quotation_Tour_Room_Detail where Created_By in(5162)
delete from  S_Quotation_Tour_Itinerary_Detail where Created_By in(5162)
delete from  S_Quotation_Additional_Charge_Detail where Created_By in(5162)
delete from  S_Quotation_Additional_Service_Detail where Created_By in(5162)
Delete from  S_Quotation_Tour_Cost_Details
Delete from S_Quotation_Tour_Room_Details



SELECT * FROM S_Quotation_Master where Created_By in(5162)
SELECT * FROM S_Quotation_Items where Created_By in(5162)  
SELECT * FROM S_Quotation_Tour_Details where Created_By in(5162)
SELECT * FROM  S_Quotation_Tour_Room_Detail where Created_By in(5162)
SELECT * FROM  S_Quotation_Tour_CostDetails where CreatedBy in(5162)
SELECT * FROM  S_Quotation_Additional_Charge_Detail where Created_By in(5162)
SELECT * FROM  S_Quotation_Additional_Service_Detail where Created_By in(5162)

--delete from  S_Quotation_Hotel_Details
--delete from  S_Invoice_Hotel_Details
--delete from  S_Invoice_Tax_Details
--delete from  S_Payment_Master where Created_By in(5162)





SELECT * FROM S_Invoice_Tour_Details
SELECT * FROM  S_Invoice_Tour_Room_Detail
SELECT * FROM S_Invoice_Tour_Itinerary_Detail
SELECT * FROM S_Invoice_Items
SELECT * FROM S_Invoice_Master
SELECT * FROM S_Invoice_Tax_Details

SELECT * FROM S_Tax_Master
SELECT * FROM S_Lead_Master
SELECT * FROM S_App_Code_Master
SELECT * FROM S_Target_Master

Delete S_Invoice_Tour_Details where Created_By in(5165)
Delete  S_Invoice_Tour_Room_Detail where Created_By in(5165)
Delete S_Invoice_Tour_Itinerary_Detail where Created_By in(5165)
Delete S_Invoice_Items where Created_By in(5165)
Delete S_Invoice_Master where Created_By in(5165)
Delete S_Invoice_Tax_Details where Created_By in(5162)
delete from  S_Invoice_Additional_Charge_Detail where Created_By in(5165)
delete from  S_Invoice_Additional_Service_Detail where Created_By in(5165)  



--truncate table S_Invoice_Hotel_Details
--truncate table S_Invoice_Items
---Delete S_Enquiry_Tour_Detail
--truncate table S_Invoice_Tax_Details

SELECT * FROM S_Vender_Service_Mapping
SELECT * FROM S_Vendor_Master
SELECT * FROM S_Tax_Master

--Delete S_Vender_Service_Mapping
--Delete S_Vendor_Master
--Delete S_Tax_Master
