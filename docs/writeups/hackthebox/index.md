# Hack The Box

Máquinas resueltas en [Hack The Box](https://www.hackthebox.com/).
<br>

<div class="htb-filters">
  <div class="fhead">Filtros</div>
  <div class="fgroup"><span class="flabel">SO</span><div class="fchips"><button class="f" data-cat="so" data-f="|Linux|">Linux</button><button class="f" data-cat="so" data-f="|Windows|">Windows</button></div></div><div class="fgroup"><span class="flabel">Dificultad</span><div class="fchips"><button class="f" data-cat="dif" data-f="|Easy|">Easy</button><button class="f" data-cat="dif" data-f="|Hard|">Hard</button><button class="f" data-cat="dif" data-f="|Medium|">Medium</button></div></div><div class="fgroup"><span class="flabel">Ataque</span><div class="fchips"><button class="f" data-cat="atk" data-f="|Command injection|">Command injection</button><button class="f" data-cat="atk" data-f="|Credenciales por defecto|">Credenciales por defecto</button><button class="f" data-cat="atk" data-f="|Deserialización|">Deserialización</button><button class="f" data-cat="atk" data-f="|Exploit público/CVE|">Exploit público/CVE</button><button class="f" data-cat="atk" data-f="|File upload|">File upload</button><button class="f" data-cat="atk" data-f="|Fuerza bruta|">Fuerza bruta</button><button class="f" data-cat="atk" data-f="|LFI|">LFI</button><button class="f" data-cat="atk" data-f="|SQLi|">SQLi</button><button class="f" data-cat="atk" data-f="|SSTI|">SSTI</button><button class="f" data-cat="atk" data-f="|XSS|">XSS</button></div></div><div class="fgroup"><span class="flabel">App</span><div class="fchips"><button class="f" data-cat="app" data-f="|Drupal|">Drupal</button><button class="f" data-cat="app" data-f="|FTP|">FTP</button><button class="f" data-cat="app" data-f="|Jenkins|">Jenkins</button><button class="f" data-cat="app" data-f="|SMB|">SMB</button><button class="f" data-cat="app" data-f="|Tomcat|">Tomcat</button><button class="f" data-cat="app" data-f="|WordPress|">WordPress</button></div></div><div class="fgroup"><span class="flabel">Escalada</span><div class="fchips"><button class="f" data-cat="esc" data-f="|Capabilities|">Capabilities</button><button class="f" data-cat="esc" data-f="|Cron|">Cron</button><button class="f" data-cat="esc" data-f="|Kernel exploit|">Kernel exploit</button><button class="f" data-cat="esc" data-f="|PATH hijacking|">PATH hijacking</button><button class="f" data-cat="esc" data-f="|Reutilización credenciales|">Reutilización credenciales</button><button class="f" data-cat="esc" data-f="|SUID|">SUID</button><button class="f" data-cat="esc" data-f="|Servicio root editable|">Servicio root editable</button><button class="f" data-cat="esc" data-f="|Token impersonation|">Token impersonation</button><button class="f" data-cat="esc" data-f="|sudo/GTFOBins|">sudo/GTFOBins</button></div></div>
  <div class="fbar"><button id="htb-clear">Limpiar filtros</button><span id="htb-count"></span></div>
</div>
<table class="htb-table">
<thead><tr><th>Máquina</th><th>SO</th><th>Dificultad</th><th>Etiquetas</th></tr></thead>
<tbody>
<tr data-tags="|Linux| |Easy| |SQLi| |LFI| |File upload| |Command injection| |XSS| |Fuerza bruta| |SUID| |Reutilización credenciales| |Servicio root editable|"><td><a href="alert/">Alert</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">SQLi</span><span class="tag">LFI</span><span class="tag">File upload</span><span class="tag">Command injection</span><span class="tag">XSS</span><span class="tag">Fuerza bruta</span><span class="tag">SUID</span><span class="tag">Reutilización credenciales</span><span class="tag">Servicio root editable</span></td></tr>
<tr data-tags="|Linux| |Easy| |Fuerza bruta| |Exploit público/CVE| |PATH hijacking|"><td><a href="antique/">Antique</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Fuerza bruta</span><span class="tag">Exploit público/CVE</span><span class="tag">PATH hijacking</span></td></tr>
<tr data-tags="|Linux| |Medium| |Fuerza bruta| |Exploit público/CVE| |WordPress| |sudo/GTFOBins| |SUID| |Capabilities| |Reutilización credenciales|"><td><a href="apocalyst/">Apocalyst</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">Fuerza bruta</span><span class="tag">Exploit público/CVE</span><span class="tag">WordPress</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Capabilities</span><span class="tag">Reutilización credenciales</span></td></tr>
<tr data-tags="|Linux| |Easy| |File upload| |sudo/GTFOBins| |SUID| |Cron|"><td><a href="bashed/">Bashed</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">File upload</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Cron</span></td></tr>
<tr data-tags="|Linux| |Easy| |Fuerza bruta| |WordPress| |FTP| |sudo/GTFOBins| |SUID|"><td><a href="blocky/">Blocky</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Fuerza bruta</span><span class="tag">WordPress</span><span class="tag">FTP</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Linux| |Easy| |File upload| |Exploit público/CVE| |Credenciales por defecto| |SUID|"><td><a href="boardlight/">BoardLight</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">File upload</span><span class="tag">Exploit público/CVE</span><span class="tag">Credenciales por defecto</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Linux| |Medium| |SSTI| |sudo/GTFOBins| |SUID|"><td><a href="bolt/">Bolt</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">SSTI</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Linux| |Easy| |FTP| |SUID| |Capabilities|"><td><a href="cap/">Cap</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">FTP</span><span class="tag">SUID</span><span class="tag">Capabilities</span></td></tr>
<tr data-tags="|Linux| |Medium| |WordPress| |sudo/GTFOBins| |SUID| |PATH hijacking| |Reutilización credenciales|"><td><a href="chaos/">Chaos</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">WordPress</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">PATH hijacking</span><span class="tag">Reutilización credenciales</span></td></tr>
<tr data-tags="|Linux| |Easy| |LFI| |Exploit público/CVE| |sudo/GTFOBins| |SUID| |Capabilities|"><td><a href="chemistry/">Chemistry</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">LFI</span><span class="tag">Exploit público/CVE</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Capabilities</span></td></tr>
<tr data-tags="|Linux| |Easy| |LFI| |sudo/GTFOBins|"><td><a href="code/">Code</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">LFI</span><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Linux| |Easy| |Command injection| |sudo/GTFOBins|"><td><a href="cozyhosting/">CozyHosting</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Command injection</span><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Linux| |Easy| |LFI| |SMB|"><td><a href="crafty/">Crafty</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">LFI</span><span class="tag">SMB</span></td></tr>
<tr data-tags="|Linux| |Easy| |LFI| |XSS| |sudo/GTFOBins| |SUID| |Capabilities|"><td><a href="delivery/">Delivery</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">LFI</span><span class="tag">XSS</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Capabilities</span></td></tr>
<tr data-tags="|Windows| |Easy| |File upload| |Exploit público/CVE| |Credenciales por defecto| |SMB| |FTP| |Token impersonation|"><td><a href="devel/">Devel</a></td><td>Windows</td><td>Easy</td><td class="tags"><span class="tag">File upload</span><span class="tag">Exploit público/CVE</span><span class="tag">Credenciales por defecto</span><span class="tag">SMB</span><span class="tag">FTP</span><span class="tag">Token impersonation</span></td></tr>
<tr data-tags="|Linux| |Medium| |SQLi| |LFI| |XSS| |Exploit público/CVE| |SUID| |Cron|"><td><a href="devzat/">Devzat</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">SQLi</span><span class="tag">LFI</span><span class="tag">XSS</span><span class="tag">Exploit público/CVE</span><span class="tag">SUID</span><span class="tag">Cron</span></td></tr>
<tr data-tags="|Windows| |Easy| |Exploit público/CVE| |Credenciales por defecto| |SMB| |Token impersonation|"><td><a href="driver/">Driver</a></td><td>Windows</td><td>Easy</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">Credenciales por defecto</span><span class="tag">SMB</span><span class="tag">Token impersonation</span></td></tr>
<tr data-tags="|Linux| |Easy| |sudo/GTFOBins| |SUID| |Capabilities|"><td><a href="editorial/">Editorial</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Capabilities</span></td></tr>
<tr data-tags="|Linux| |Easy| |Exploit público/CVE|"><td><a href="expressway/">Expressway</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Exploit público/CVE</span></td></tr>
<tr data-tags="|Linux| |Medium| |SSTI| |Exploit público/CVE| |SUID|"><td><a href="flustered/">Flustered</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">SSTI</span><span class="tag">Exploit público/CVE</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Linux| |Easy| |SQLi| |SSTI| |XSS| |Credenciales por defecto| |SUID| |Capabilities| |PATH hijacking| |Reutilización credenciales|"><td><a href="goodgames/">GoodGames</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">SQLi</span><span class="tag">SSTI</span><span class="tag">XSS</span><span class="tag">Credenciales por defecto</span><span class="tag">SUID</span><span class="tag">Capabilities</span><span class="tag">PATH hijacking</span><span class="tag">Reutilización credenciales</span></td></tr>
<tr data-tags="|Windows| |Easy| |Exploit público/CVE| |WordPress| |SMB| |Token impersonation|"><td><a href="grandpa/">Grandpa</a></td><td>Windows</td><td>Easy</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">WordPress</span><span class="tag">SMB</span><span class="tag">Token impersonation</span></td></tr>
<tr data-tags="|Windows| |Easy| |Exploit público/CVE| |SMB|"><td><a href="granny/">Granny</a></td><td>Windows</td><td>Easy</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">SMB</span></td></tr>
<tr data-tags="|Linux| |Medium| |Fuerza bruta| |Exploit público/CVE| |WordPress| |Drupal| |FTP| |sudo/GTFOBins| |SUID| |Reutilización credenciales|"><td><a href="hawk/">Hawk</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">Fuerza bruta</span><span class="tag">Exploit público/CVE</span><span class="tag">WordPress</span><span class="tag">Drupal</span><span class="tag">FTP</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Reutilización credenciales</span></td></tr>
<tr data-tags="|Linux| |Easy| |File upload| |Exploit público/CVE|"><td><a href="horizontal/">Horizontal</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">File upload</span><span class="tag">Exploit público/CVE</span></td></tr>
<tr data-tags="|Linux| |Medium| |LFI| |Fuerza bruta|"><td><a href="instant/">Instant</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">LFI</span><span class="tag">Fuerza bruta</span></td></tr>
<tr data-tags="|Linux| |Easy| |SUID|"><td><a href="irked/">Irked</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">SUID</span></td></tr>
<tr data-tags="|Linux| |Medium| |SQLi| |File upload| |sudo/GTFOBins| |SUID|"><td><a href="jarvis/">Jarvis</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">SQLi</span><span class="tag">File upload</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Windows| |Medium| |Exploit público/CVE| |Credenciales por defecto| |Jenkins| |SMB| |Token impersonation|"><td><a href="jeeves/">Jeeves</a></td><td>Windows</td><td>Medium</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">Credenciales por defecto</span><span class="tag">Jenkins</span><span class="tag">SMB</span><span class="tag">Token impersonation</span></td></tr>
<tr data-tags="|Linux| |Easy| |Tomcat|"><td><a href="jerry/">Jerry</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Tomcat</span></td></tr>
<tr data-tags="|Linux| |Easy| |Fuerza bruta| |Credenciales por defecto|"><td><a href="keeper/">Keeper</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Fuerza bruta</span><span class="tag">Credenciales por defecto</span></td></tr>
<tr data-tags="|Linux| |Easy| |sudo/GTFOBins| |SUID|"><td><a href="knife/">Knife</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Linux| |Easy| |Exploit público/CVE| |Credenciales por defecto| |SMB| |FTP|"><td><a href="lame/">Lame</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">Credenciales por defecto</span><span class="tag">SMB</span><span class="tag">FTP</span></td></tr>
<tr data-tags="|Windows| |Easy| |Exploit público/CVE| |SMB| |Kernel exploit|"><td><a href="legacy/">Legacy</a></td><td>Windows</td><td>Easy</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">SMB</span><span class="tag">Kernel exploit</span></td></tr>
<tr data-tags="|Windows| |Easy| |File upload| |SMB| |Reutilización credenciales|"><td><a href="love/">Love</a></td><td>Windows</td><td>Easy</td><td class="tags"><span class="tag">File upload</span><span class="tag">SMB</span><span class="tag">Reutilización credenciales</span></td></tr>
<tr data-tags="|Linux| |Easy| |Credenciales por defecto| |sudo/GTFOBins|"><td><a href="mirai/">Mirai</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Credenciales por defecto</span><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Windows| |Easy| |Exploit público/CVE| |Credenciales por defecto| |SMB| |FTP|"><td><a href="netmon/">Netmon</a></td><td>Windows</td><td>Easy</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">Credenciales por defecto</span><span class="tag">SMB</span><span class="tag">FTP</span></td></tr>
<tr data-tags="|Linux| |Easy| |File upload| |Command injection| |sudo/GTFOBins| |SUID| |Cron|"><td><a href="networked/">Networked</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">File upload</span><span class="tag">Command injection</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Cron</span></td></tr>
<tr data-tags="|Linux| |Easy| |File upload| |Exploit público/CVE| |sudo/GTFOBins| |SUID| |Capabilities|"><td><a href="nibbles/">Nibbles</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">File upload</span><span class="tag">Exploit público/CVE</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Capabilities</span></td></tr>
<tr data-tags="|Linux| |Medium| |XSS| |Deserialización| |Fuerza bruta| |Credenciales por defecto|"><td><a href="nodeblog/">NodeBlog</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">XSS</span><span class="tag">Deserialización</span><span class="tag">Fuerza bruta</span><span class="tag">Credenciales por defecto</span></td></tr>
<tr data-tags="|Linux| |Medium| |SSTI| |sudo/GTFOBins| |SUID| |Capabilities| |Reutilización credenciales|"><td><a href="nunchucks/">Nunchucks</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">SSTI</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Capabilities</span><span class="tag">Reutilización credenciales</span></td></tr>
<tr data-tags="|Linux| |Easy| |Exploit público/CVE| |sudo/GTFOBins| |SUID| |Capabilities| |Reutilización credenciales|"><td><a href="permx/">PermX</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Capabilities</span><span class="tag">Reutilización credenciales</span></td></tr>
<tr data-tags="|Linux| |Easy| |LFI| |Exploit público/CVE|"><td><a href="pilgrimage/">Pilgrimage</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">LFI</span><span class="tag">Exploit público/CVE</span></td></tr>
<tr data-tags="|Linux| |Medium| |LFI| |SUID|"><td><a href="poison/">Poison</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">LFI</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Linux| |Medium| |File upload| |Exploit público/CVE| |Kernel exploit| |Reutilización credenciales|"><td><a href="popcorn/">Popcorn</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">File upload</span><span class="tag">Exploit público/CVE</span><span class="tag">Kernel exploit</span><span class="tag">Reutilización credenciales</span></td></tr>
<tr data-tags="|Linux| |Easy| |SQLi| |LFI| |Command injection| |Fuerza bruta| |sudo/GTFOBins| |SUID| |Cron| |PATH hijacking|"><td><a href="previse/">Previse</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">SQLi</span><span class="tag">LFI</span><span class="tag">Command injection</span><span class="tag">Fuerza bruta</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Cron</span><span class="tag">PATH hijacking</span></td></tr>
<tr data-tags="|Windows| |Easy| |SMB|"><td><a href="return/">Return</a></td><td>Windows</td><td>Easy</td><td class="tags"><span class="tag">SMB</span></td></tr>
<tr data-tags="|Linux| |Easy| |Command injection| |Exploit público/CVE| |sudo/GTFOBins| |Cron| |PATH hijacking|"><td><a href="scriptkiddie/">ScriptKiddie</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Command injection</span><span class="tag">Exploit público/CVE</span><span class="tag">sudo/GTFOBins</span><span class="tag">Cron</span><span class="tag">PATH hijacking</span></td></tr>
<tr data-tags="|Linux| |Easy| |Exploit público/CVE| |sudo/GTFOBins|"><td><a href="shocked/">Shocked</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Linux| |Medium| |Credenciales por defecto| |SUID|"><td><a href="solidstate/">SolidState</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">Credenciales por defecto</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Linux| |Easy| |XSS| |Fuerza bruta| |Exploit público/CVE| |WordPress| |sudo/GTFOBins| |SUID| |Reutilización credenciales|"><td><a href="spectra/">Spectra</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">XSS</span><span class="tag">Fuerza bruta</span><span class="tag">Exploit público/CVE</span><span class="tag">WordPress</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span><span class="tag">Reutilización credenciales</span></td></tr>
<tr data-tags="|Linux| |Medium| |Exploit público/CVE| |Credenciales por defecto| |Tomcat| |sudo/GTFOBins|"><td><a href="stratosphere/">Stratosphere</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">Credenciales por defecto</span><span class="tag">Tomcat</span><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Linux| |Medium| |File upload| |XSS| |Fuerza bruta| |Exploit público/CVE| |WordPress| |sudo/GTFOBins|"><td><a href="tenten/">Tenten</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">File upload</span><span class="tag">XSS</span><span class="tag">Fuerza bruta</span><span class="tag">Exploit público/CVE</span><span class="tag">WordPress</span><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Windows| |Easy| |SQLi| |Credenciales por defecto| |SMB| |FTP|"><td><a href="toolbox/">Toolbox</a></td><td>Windows</td><td>Easy</td><td class="tags"><span class="tag">SQLi</span><span class="tag">Credenciales por defecto</span><span class="tag">SMB</span><span class="tag">FTP</span></td></tr>
<tr data-tags="|Linux| |Medium| |SQLi| |XSS| |sudo/GTFOBins|"><td><a href="union/">Union</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">SQLi</span><span class="tag">XSS</span><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Linux| |Easy| |SQLi| |File upload| |SSTI| |XSS| |Credenciales por defecto|"><td><a href="validation/">Validation</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">SQLi</span><span class="tag">File upload</span><span class="tag">SSTI</span><span class="tag">XSS</span><span class="tag">Credenciales por defecto</span></td></tr>
<tr data-tags="|Linux| |Medium| |LFI| |XSS| |Capabilities|"><td><a href="waldo/">Waldo</a></td><td>Linux</td><td>Medium</td><td class="tags"><span class="tag">LFI</span><span class="tag">XSS</span><span class="tag">Capabilities</span></td></tr>
<tr data-tags="|Linux| |Easy| |LFI| |Exploit público/CVE| |FTP| |sudo/GTFOBins| |SUID|"><td><a href="wingdata/">Wingdata</a></td><td>Linux</td><td>Easy</td><td class="tags"><span class="tag">LFI</span><span class="tag">Exploit público/CVE</span><span class="tag">FTP</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span></td></tr>
</tbody>
</table>

<style>
.htb-filters{margin:1em 0;border:1px solid var(--md-primary-fg-color--light);
  border-left:4px solid var(--md-accent-fg-color);border-radius:8px;overflow:hidden;
  background:rgba(77,143,214,.07)}
.htb-filters .fhead{padding:.45em .9em;font-size:.72rem;font-weight:700;letter-spacing:.05em;
  text-transform:uppercase;color:#fff;background:var(--md-primary-fg-color)}
.fgroup{display:grid;grid-template-columns:6.5em 1fr;gap:.6em;align-items:start;
  padding:.5em .9em;border-top:1px solid var(--md-default-fg-color--lightest)}
.flabel{font-size:.7rem;font-weight:700;text-transform:uppercase;opacity:.65;padding-top:.25em;
  color:var(--md-accent-fg-color)}
.fchips{display:flex;flex-wrap:wrap;gap:.35em}
.htb-filters button.f{font-size:.72rem;padding:.15em .65em;border:1px solid var(--md-accent-fg-color);
  border-radius:999px;background:transparent;color:var(--md-default-fg-color);cursor:pointer;
  transition:all .12s}
.htb-filters button.f:hover{background:rgba(77,143,214,.15)}
.htb-filters button.f.on{background:var(--md-accent-fg-color);border-color:var(--md-accent-fg-color);color:#fff}
.fbar{padding:.55em .9em;border-top:1px solid var(--md-default-fg-color--lightest);
  display:flex;align-items:center;gap:1em}
#htb-clear{font-size:.72rem;padding:.2em .8em;border:1px solid var(--md-accent-fg-color);
  border-radius:6px;background:transparent;color:var(--md-accent-fg-color);cursor:pointer}
#htb-count{font-size:.75rem;opacity:.7}
.htb-table{width:100%;border-collapse:collapse;font-size:.8rem}
.htb-table th,.htb-table td{text-align:left;padding:.45em .6em;
  border-bottom:1px solid var(--md-default-fg-color--lightest);vertical-align:top}
.htb-table td.tags{line-height:2}
.htb-table .tag{font-size:.68rem;padding:.1em .5em;margin:0 .15em;border-radius:999px;
  background:var(--md-primary-fg-color--light);color:#fff;white-space:nowrap;display:inline-block}
</style>

<script>
(function(){
  function init(){
    if(!document.querySelector('.htb-table')) return;
    var rows=[].slice.call(document.querySelectorAll('.htb-table tbody tr'));
    var btns=[].slice.call(document.querySelectorAll('.htb-filters button.f'));
    var count=document.getElementById('htb-count');
    var active={};
    function apply(){
      var cats=Object.keys(active).filter(function(c){return active[c].size});
      var vis=0;
      rows.forEach(function(r){
        var t=r.getAttribute('data-tags');
        var ok=cats.every(function(c){return [...active[c]].some(function(f){return t.indexOf(f)>=0})});
        r.style.display=ok?'':'none'; if(ok)vis++;
      });
      if(count) count.textContent=vis+' / '+rows.length+' máquinas';
    }
    btns.forEach(function(b){b.addEventListener('click',function(){
      var c=b.getAttribute('data-cat'), f=b.getAttribute('data-f');
      if(!active[c]) active[c]=new Set();
      if(active[c].has(f)){active[c].delete(f);b.classList.remove('on');}
      else{active[c].add(f);b.classList.add('on');}
      apply();
    })});
    var clr=document.getElementById('htb-clear');
    if(clr) clr.addEventListener('click',function(){active={};btns.forEach(function(b){b.classList.remove('on')});apply();});
    apply();
  }
  if (typeof document$ !== 'undefined') document$.subscribe(init);
  else document.addEventListener('DOMContentLoaded', init);
})();
</script>