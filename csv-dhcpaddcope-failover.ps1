# This script creates DHCP scopes using a csv. 
# It will loop through the csv, add the scopes, set scope options, add the scope to an existing failover relationship, and replicate the scope failover to the other DHCP server
#
# Path to csv must be set following Import-Csv
# Variable $dhcpServer must be set to the FQDN of the primary DHCP server
# Variable $dhcpFailover must be set to the name of the failover relationship
# The -Force switch stops the script from asking for confirmation for failover replication 
#
$dhcpScopeSource = Import-Csv “filename.csv”
$dhcpServer = "FQDN of Primary DHCP server"
$dhcpFailover = "DHCP-Failover-Name"
ForEach($dhcpScope In $dhcpScopeSource){
    $dhcpScope.Subnet
    Add-DhcpServerv4Scope -ComputerName $dhcpServer -Name $dhcpScope.Name -SubnetMask $dhcpScope.Mask -StartRange $dhcpScope.StartRange -EndRange $dhcpScope.EndRange -LeaseDuration $dhcpScope.LeaseDuration
    Set-DhcpServerv4OptionValue -ComputerName $dhcpServer -ScopeId $dhcpScope.Subnet -DnsDomain $dhcpScope.DNSDomain -DnsServer $dhcpScope.NameServer,$dhcpScope.NameServer2 -Router $dhcpScope.Gateway
    Add-DhcpServerv4FailoverScope -ComputerName $dhcpServer -Name $dhcpFailover -ScopeId $dhcpScope.Subnet
    Invoke-DhcpServerv4FailoverReplication -ComputerName $dhcpServer -ScopeId $dhcpScope.Subnet -Force
}
