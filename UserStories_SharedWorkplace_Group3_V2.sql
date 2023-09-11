USE SharedWorkspace

/*
1.	As an owner, I can list a property with its address, neighborhood, square feet, whether it has a parking garage,
and whether it is reachable by public transportation.
*/

SELECT addressNumber+ ' - '+ AddressStreet AS Address, NeighborhoodName AS Neighborhood, ParkingGarage, Size AS [Size (sf)],
TransportationTypeName + ' - ' + TransportationLineName + ' - Station: ' + TransportationStationName AS [Public Transportation]
FROM Property
 INNER JOIN Neighborhood ON Property.NeighborhoodID = Neighborhood.NeighborhoodID
 INNER JOIN Workspace ON Property.PropertyID = Workspace.PropertyID
 INNER JOIN PublicTransportation ON Property.PublicTransportationID = PublicTransportation.PublicTransportationID
 INNER JOIN TransportationTypeLine ON TransportationTypeLine.TransportationTypeLineID = PublicTransportation.TransportationTypeLineID
 INNER JOIN TransportationType ON TransportationTypeLine.TransportationTypeID = TransportationType.TransportationTypeID
 INNER JOIN TransportationLine ON TransportationTypeLine.TransportationLineID = TransportationLine.TransportationLineID
 INNER JOIN TransportationStation ON PublicTransportation.TransportationStationID = TransportationStation.TransportationStationID

 /*
 2.	As an owner, I can select one of my properties and list workspaces for rent. Workspaces could be meeting rooms, private office rooms,
 or desks in an open work area.
 For each workspace, I can specify how many individuals it can seat, whether smoking is allowed or not,
 lease term (day, week, or month), and price.
 */

 SELECT Name, PropertyName, WorkspaceName, TypeOfWorkspace, Seats, Smoking, LeasePeriod, Price
 FROM Users
 JOIN PropertyOwners ON Users.UserID = PropertyOwners.UserID
 JOIN Property ON Property.PropertyID = PropertyOwners.PropertyID
 JOIN Workspace ON Property.PropertyID = Workspace.PropertyID
 JOIN WorkspaceType ON Workspace.WorkspaceTypeID = WorkspaceType.WorkspaceTypeID
 JOIN LeaseTerm ON Workspace.LeaseTermID = LeaseTerm.LeaseTermID
 WHERE Users.UserID= 3
 
 /*
 3.	As a coworker, I can search for workspaces by address, neighborhood, square feet, with/without parking,
 with/without public transportation, number of individuals it can seat, with/without smoking,  lease term, or price.
 */

 SELECT WorkspaceName, PropertyName, addressNumber+ ' - '+ AddressStreet AS Address, NeighborhoodName AS Neighborhood, ParkingGarage, Size AS [Size (sf)],
TransportationTypeName + ' - ' + TransportationLineName + ' - Station: ' + TransportationStationName AS [Public Transportation], Seats,
Smoking, LeasePeriod, Price
FROM Property
 INNER JOIN Neighborhood ON Property.NeighborhoodID = Neighborhood.NeighborhoodID
 INNER JOIN Workspace ON Property.PropertyID = Workspace.PropertyID
 INNER JOIN PublicTransportation ON Property.PublicTransportationID = PublicTransportation.PublicTransportationID
 INNER JOIN TransportationTypeLine ON TransportationTypeLine.TransportationTypeLineID = PublicTransportation.TransportationTypeLineID
 INNER JOIN TransportationType ON TransportationTypeLine.TransportationTypeID = TransportationType.TransportationTypeID
 INNER JOIN TransportationLine ON TransportationTypeLine.TransportationLineID = TransportationLine.TransportationLineID
 INNER JOIN TransportationStation ON PublicTransportation.TransportationStationID = TransportationStation.TransportationStationID
 INNER JOIN LeaseTerm ON Workspace.LeaseTermID = LeaseTerm.LeaseTermID

 /*
 4.	As a coworker, I can select a workspace and view its details.
 */

 SELECT WorkspaceName, PropertyName, Seats, Smoking, LeasePeriod, Price, Size
 FROM Workspace
 JOIN Property ON Workspace.PropertyID = Property.PropertyID
 JOIN LeaseTerm ON Workspace.LeaseTermID = LeaseTerm.LeaseTermID

 /*
 5.	As a coworker, I can get the contact information of a workspace’s owner.
 */

 SELECT Name, Phone, Email
 FROM Users
 WHERE RoleID = 1

 /*
 6. My name is Ethan Johnson and as an user, I want to know all the days I used each workspace and the sum of days each time
 */

 SELECT Users.Name, UsageDateInitial, UsageDateFinal, DATEDIFF(DAY,UsageDateInitial, UsageDateFinal) AS Totalofdays, WorkspaceName
 FROM WorkspaceUsage
 JOIN Users ON WorkspaceUsage.UserID= Users.UserID
 JOIN Workspace ON WorkspaceUsage.WorkspaceID = Workspace.WorkspaceID
 WHERE Users.UserID = 6

 /*
 7. As the adm of the app, I want to know the usage of all workspace before today and the coworker that used the space
 */
 SELECT WorkspaceName, NumberOfUsers, Name AS [User name], Phone, Email, UsageTypeName, DATEDIFF(DAY,UsageDateInitial, UsageDateFinal) AS Totalofdays
 FROM WorkspaceUsage
 JOIN Users ON WorkspaceUsage.UserID= Users.UserID
 JOIN WorkspaceUsageType ON WorkspaceUsage.WorkspaceUsageTypeID= WorkspaceUsageType.WorkspaceUsageTypeID
 JOIN Workspace ON WorkspaceUsage.WorkspaceID = Workspace.WorkspaceID
 WHERE UsageDateInitial < GETDATE()

  
 /*
 8. My name is Samantha Chen and I want to know the usage of my workspace before today and the coworker that used the space
  */
 SELECT WorkspaceName, NumberOfUsers, Users.Name AS [User name], Users.Phone, Users.Email, UsageTypeName, UsageDateInitial, U.Name AS [Owner Name]
 FROM WorkspaceUsage
 JOIN Users ON WorkspaceUsage.UserID= Users.UserID
 JOIN WorkspaceUsageType ON WorkspaceUsage.WorkspaceUsageTypeID= WorkspaceUsageType.WorkspaceUsageTypeID
 JOIN Workspace ON WorkspaceUsage.WorkspaceID = Workspace.WorkspaceID
 JOIN Property ON Workspace.WorkspaceID = Property.PropertyID
 JOIN PropertyOwners ON Property.PropertyID = PropertyOwners.PropertyID
 JOIN [Users] U ON PropertyOwners.UserID = U.UserID
 WHERE UsageDateInitial < GETDATE() AND U.Name= 'Samantha Chen'

 /*
 For each workspace list:
 1. Name
 2. Total of users
 3. Total money received
 And list a summarize of users and money received
 */
 SELECT COALESCE (workspaceName, 'TOTAL') AS [Workspace Name], SUM(NumberOFUsers) AS [Number of users], SUM(Price) AS [Total received]
 FROM WorkspaceUsage
 JOIN Workspace ON WorkspaceUsage.WorkspaceID=Workspace.WorkspaceID
 GROUP BY ROLLUP (WorkspaceName)
 ORDER BY SUM(Price) ASC

 /*
 10. Inform which days each workspace is unavailable between April 20th and May 10th.
 */

 SELECT WorkspaceName, 'Availability'=
 CASE 
	WHEN	(UsageDateInitial BETWEEN '2023-04-20' AND '2023-05-10') OR
			(UsageDateFinal BETWEEN '2023-04-20' AND '2023-05-10')
			THEN 'Not available'
 END
 +' between '+ CONVERT(VARCHAR, UsageDateInitial,103)+ ' and ' + CONVERT(VARCHAR,UsageDateFinal,103)
 FROM Workspace
 JOIN WorkspaceUsage ON Workspace.WorkspaceID=WorkspaceUsage.WorkspaceID
 WHERE	(UsageDateInitial BETWEEN '2023-04-20' AND '2023-05-10') OR
		(UsageDateFinal BETWEEN '2023-04-20' AND '2023-05-10')

/* 
11. As a user I want to know if the Montain Meeting Room will be available on 28/04/2023.
*/ 
SELECT 
  CASE 
    WHEN COUNT(*) > 0 THEN 'NOT AVAILABLE'
    ELSE 'AVAILABLE'
  END AS STATUS
FROM WorkspaceUsage 
WHERE WorkspaceID=3 AND
'2023-04-28' BETWEEN WorkspaceUsage.UsageDateInitial AND WorkspaceUsage.UsageDateFinal;