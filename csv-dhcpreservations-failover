# This script creates DHCP reservations using a csv.
# It will add the DHCP reservation and then force replication to the other DHCP server in the failover relationship
#
# Path to csv must be set following Import-Csv
# Variable $dhcpServer must be set to the FQDN of the primary DHCP server
# The -Force switch stops the script from asking for confirmation for failover replication
#
$dhcpReservationSource = Import-Csv “filename.csv”
$dhcpServer = "FQDN of DHCP server"
ForEach($dhcpReservation In $dhcpReservationSource){
    $dhcpReservation.ScopeId
    Add-DhcpServerv4Reservation -ComputerName $dhcpServer -ScopeId $dhcpReservation.ScopeId -IPAddress $dhcpReservation.IPAddress -Name $dhcpReservation.Name -ClientId $dhcpReservation.ClientId -Description $dhcpReservation.Description 
    Invoke-DhcpServerv4FailoverReplication -ComputerName $dhcpServer -ScopeId $dhcpReservation.ScopeId -Force
}
