function getLocalNetworkComputers {
     $subnet = "192.168.1"   # Cambia in base alla tua rete locale
     $reachableComputers = @()

     Write-Host "Scansione in corso sulla rete $subnet.0/24..."

     for ($i = 1; $i -le 254; $i++) {
         $ip = "$subnet.$i"
         if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
             try {
                 $hostname = [System.Net.Dns]::GetHostEntry($ip).HostName
             } catch {
                 $hostname = "Nome non trovato"
             }
             Write-Host "Rilevato: $ip ($hostname)"
             $reachableComputers += $hostname
         }
     }

     Write-Host "`nTotale dispositivi trovati: $($reachableComputers.Count)"
     return $reachableComputers
 }

 getLocalNetworkComputers