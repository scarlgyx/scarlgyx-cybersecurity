# TryHackMe

Máquinas resueltas en [TryHackMe](https://tryhackme.com/). Usa los filtros para ver, por ejemplo, todas las Windows,
las de WordPress o las que escalan por SUID. Dentro de una misma categoría los filtros suman;
entre categorías se combinan.

<div class="htb-filters">
  <div class="fhead">Filtros</div>
  <div class="fgroup"><span class="flabel">SO</span><div class="fchips"><button class="f" data-cat="so" data-f="|Linux|">Linux</button><button class="f" data-cat="so" data-f="|Windows|">Windows</button></div></div><div class="fgroup"><span class="flabel">Ataque</span><div class="fchips"><button class="f" data-cat="atk" data-f="|Credenciales por defecto|">Credenciales por defecto</button><button class="f" data-cat="atk" data-f="|Deserialización|">Deserialización</button><button class="f" data-cat="atk" data-f="|Exploit público/CVE|">Exploit público/CVE</button><button class="f" data-cat="atk" data-f="|File upload|">File upload</button><button class="f" data-cat="atk" data-f="|Fuerza bruta|">Fuerza bruta</button></div></div><div class="fgroup"><span class="flabel">App</span><div class="fchips"><button class="f" data-cat="app" data-f="|FTP|">FTP</button><button class="f" data-cat="app" data-f="|SMB|">SMB</button><button class="f" data-cat="app" data-f="|WordPress|">WordPress</button></div></div><div class="fgroup"><span class="flabel">Escalada</span><div class="fchips"><button class="f" data-cat="esc" data-f="|Cron|">Cron</button><button class="f" data-cat="esc" data-f="|Kernel exploit|">Kernel exploit</button><button class="f" data-cat="esc" data-f="|SUID|">SUID</button><button class="f" data-cat="esc" data-f="|sudo/GTFOBins|">sudo/GTFOBins</button></div></div>
  <div class="fbar"><button id="htb-clear">Limpiar filtros</button><span id="htb-count"></span></div>
</div>

<table class="htb-table">
<thead><tr><th>Máquina</th><th>SO</th><th>Etiquetas</th></tr></thead>
<tbody>
<tr data-tags="|Linux| |Fuerza bruta| |SMB|"><td><a href="basicpentesting/">Basic Pentesting</a></td><td>Linux</td><td class="tags"><span class="tag">Fuerza bruta</span><span class="tag">SMB</span></td></tr>
<tr data-tags="|Linux|"><td><a href="blaster/">Blaster</a></td><td>Linux</td><td class="tags"></td></tr>
<tr data-tags="|Linux| |Fuerza bruta| |Exploit público/CVE| |WordPress| |SMB| |sudo/GTFOBins| |SUID|"><td><a href="blog/">Blog</a></td><td>Linux</td><td class="tags"><span class="tag">Fuerza bruta</span><span class="tag">Exploit público/CVE</span><span class="tag">WordPress</span><span class="tag">SMB</span><span class="tag">sudo/GTFOBins</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Windows| |Exploit público/CVE| |SMB| |Kernel exploit|"><td><a href="blue/">Blue</a></td><td>Windows</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">SMB</span><span class="tag">Kernel exploit</span></td></tr>
<tr data-tags="|Linux| |Exploit público/CVE|"><td><a href="bolt/">Bolt</a></td><td>Linux</td><td class="tags"><span class="tag">Exploit público/CVE</span></td></tr>
<tr data-tags="|Linux| |Fuerza bruta| |Credenciales por defecto| |FTP| |sudo/GTFOBins|"><td><a href="chillhack/">Chill Hack</a></td><td>Linux</td><td class="tags"><span class="tag">Fuerza bruta</span><span class="tag">Credenciales por defecto</span><span class="tag">FTP</span><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Linux| |sudo/GTFOBins|"><td><a href="chocolatefactory/">Chocolate Factory</a></td><td>Linux</td><td class="tags"><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Linux| |File upload| |Fuerza bruta| |WordPress|"><td><a href="colddbox/">ColddBox</a></td><td>Linux</td><td class="tags"><span class="tag">File upload</span><span class="tag">Fuerza bruta</span><span class="tag">WordPress</span></td></tr>
<tr data-tags="|Linux| |Credenciales por defecto|"><td><a href="corridor/">Corridor</a></td><td>Linux</td><td class="tags"><span class="tag">Credenciales por defecto</span></td></tr>
<tr data-tags="|Linux| |Cron|"><td><a href="easypeasy/">Easy Peasy</a></td><td>Linux</td><td class="tags"><span class="tag">Cron</span></td></tr>
<tr data-tags="|Windows| |Exploit público/CVE| |SMB| |Kernel exploit|"><td><a href="ice/">Ice</a></td><td>Windows</td><td class="tags"><span class="tag">Exploit público/CVE</span><span class="tag">SMB</span><span class="tag">Kernel exploit</span></td></tr>
<tr data-tags="|Linux| |File upload| |Exploit público/CVE|"><td><a href="ignite/">Ignite</a></td><td>Linux</td><td class="tags"><span class="tag">File upload</span><span class="tag">Exploit público/CVE</span></td></tr>
<tr data-tags="|Linux| |Fuerza bruta| |Exploit público/CVE| |WordPress| |FTP| |SUID|"><td><a href="mrrobotctf/">Mr Robot CTF</a></td><td>Linux</td><td class="tags"><span class="tag">Fuerza bruta</span><span class="tag">Exploit público/CVE</span><span class="tag">WordPress</span><span class="tag">FTP</span><span class="tag">SUID</span></td></tr>
<tr data-tags="|Linux| |Deserialización| |sudo/GTFOBins|"><td><a href="picklerick/">Pickle Rick</a></td><td>Linux</td><td class="tags"><span class="tag">Deserialización</span><span class="tag">sudo/GTFOBins</span></td></tr>
<tr data-tags="|Linux|"><td><a href="rootme/">Root Me</a></td><td>Linux</td><td class="tags"></td></tr>
<tr data-tags="|Linux| |FTP| |Cron|"><td><a href="startup/">Startup</a></td><td>Linux</td><td class="tags"><span class="tag">FTP</span><span class="tag">Cron</span></td></tr>
<tr data-tags="|Linux|"><td><a href="takeover/">TakeOver</a></td><td>Linux</td><td class="tags"></td></tr>
<tr data-tags="|Linux| |SUID|"><td><a href="vulnversity/">Vulnversity</a></td><td>Linux</td><td class="tags"><span class="tag">SUID</span></td></tr>
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
  border-radius:999px;background:transparent;color:var(--md-default-fg-color);cursor:pointer;transition:all .12s}
.htb-filters button.f:hover{background:rgba(77,143,214,.15)}
.htb-filters button.f.on{background:var(--md-accent-fg-color);border-color:var(--md-accent-fg-color);color:#fff}
.fbar{padding:.55em .9em;border-top:1px solid var(--md-default-fg-color--lightest);display:flex;align-items:center;gap:1em}
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
