---
theme: default
title: Ticketing has a default. It's the wrong one.
colorSchema: dark
layout: cover
timer: countdown
duration: 5min
routerMode: hash
addons:
  - slidev-addon-second-screen
fonts:
  sans: 'Inter'
  serif: 'Fraunces'
  mono: 'JetBrains Mono'
---

<p class="meta">Lightning Talk · PyCon Portugal 2026 · Aveiro</p>

# Ticketing has a default. It's the wrong one.

<div class="rule"></div>

<p class="lead">Closed-source SaaS, by habit - not because it's better.</p>

<p class="meta mt-10">Afonso Santos</p>

<div class="absolute bottom-10 left-14 flex items-center gap-6">
  <img src="/pycon-logo.svg" class="h-12 object-contain" style="" alt="PyCon Portugal 2026" />
  <div class="logo-sep"></div>
  <img src="/visionsoft-white.svg" class="h-6 object-contain" alt="Visionsoft" />
</div>

<p class="fineprint absolute bottom-10 right-14">Not affiliated with or endorsed by pretix GmbH or euPago.</p>

<!--
Everyone here has used a paid, closed platform to buy a ticket. <br>Nobody chose it. <br>It's just the default. <br>Today I want to explain why it should not be.
-->

---
layout: default
timing: 15s
disabled: true
---

# Who am I

<div class="grid grid-cols-3 gap-10 mt-20">
  <div>
    <p class="meta">Role</p>
    <p class="mt-3 text-2xl">Full Stack Developer</p>
  </div>
  <div>
    <p class="meta">Company</p>
    <img src="/visionsoft-white.svg" class="h-11 object-contain mt-4" alt="Visionsoft" />
  </div>
  <div>
    <p class="meta">Based in</p>
    <p class="mt-3 text-2xl">Leiria, Portugal</p>
  </div>
</div>

<div class="rule mt-16"></div>

<p class="lead">Author of <strong>pretix-eupago</strong>.</p>

<!--
I'm a full stack developer at Visionsoft, based in Leiria. I'm also the author of pretix-eupago.
-->

---
layout: default
timing: 45s
---

# The habit

<div class="grid grid-cols-2 gap-10 mt-8">

<div>
  <p class="meta">What most events run on</p>
  <ul class="plain-list mt-2">
    <li>Closed-source SaaS</li>
    <li>Pay per ticket, forever</li>
    <li>Your data, their servers</li>
  </ul>
</div>

<div>
  <p class="meta accent">What you never get</p>
  <ul class="plain-list mt-2">
    <li>Self-hosting</li>
    <li>Code you can even read, let alone extend</li>
    <li>A plugin ecosystem you control</li>
  </ul>
</div>

</div>

<div class="rule mt-8"></div>

<p class="lead">Open-source alternatives have been sitting there the whole time.</p>

<!--
Most events use a paid, closed platform. <br>It's the default. <br>You pay per ticket, forever. <br>Your data stays on their servers. <br>But open-source options exist too. <br>pretix is one of the best.
-->

---
layout: statement
timing: 65s
---

<p class="giant-word">RENTING.</p>

<p class="lead mt-4">by default.</p>

<!--
Renting. <br>By default. <br>That is the habit we need to break.
-->

---
layout: statement
timing: 85s
---

<img src="/pretix-white.svg" class="h-12 mx-auto mb-6 object-contain" alt="PyCon Portugal 2026" />

# Enter <span class="accent">pretix</span>

<p class="lead mt-2">As good. Often better. And free.</p>

<p class="meta mt-6">Django + Python · Plugin-driven · Self-hostable · Used across Europe</p>

<!--
pretix is as good as the paid platforms. <br>In some ways, it is better. <br>It is open source, built with Django, and easy to extend.
-->

---
layout: default
timing: 115s
---

# I hit a wall

<p class="text-lg dim mt-4">I was looking for open-source ticketing for a conference of my own. pretix was the best fit - almost.</p>

<div class="grid grid-cols-2 gap-10 mt-8">

<div>
  <p class="meta">Portugal expects</p>
  <ul class="plain-list mt-2">
    <li>Multibanco references and MB WAY</li>
    <li>Fiscally valid invoices - ATCUD, AT communication</li>
  </ul>
</div>

<div>
  <p class="meta accent">pretix has / is missing</p>
  <ul class="plain-list mt-2">
    <li>Stripe, PayPal, bank transfer</li>
    <li>Missing: Multibanco, MB WAY</li>
  </ul>
</div>

</div>

<div class="rule mt-8"></div>

<p class="lead">A great product, missing a Portuguese accent.</p>

<!--
I went looking for open-source ticketing for a conference of my own. <br>pretix was the best fit I found. <br>But it is missing two things Portugal needs: local payments and legal invoices.
-->

---
layout: default
timing: 150s
---

# One gap closed

<ul class="plain-list mt-6">
<li>Generates Multibanco references per order, automatically</li>
<li>Sends MB WAY push payment requests</li>
<li>Handles async payment confirmation via webhooks</li>
<li>Open-source - Apache 2.0 - <code>pip install pretix-eupago</code></li>
</ul>

<div class="rule mt-8"></div>

<p class="lead">The plugin isn't the point. The gap was never the software's fault.</p>

<!--
So I built a plugin called pretix-eupago. It adds Multibanco and MB WAY payments. <br>It's open source. <br>But the plugin is not the real point. The real point: this gap can be closed.
-->

---
layout: default
timing: 180s
---

# Already working

<div class="grid grid-cols-2 gap-4 mt-8">

<div>
  <p class="meta">Case 01</p>
  <h3 class="mt-2">PyCon Portugal</h3>
  <p class="mt-2 text-lg dim">The event you're at right now runs on it.</p>
</div>

<div>
  <p class="meta">Case 02</p>
  <h3 class="mt-2">Portuguese Society of Chinese Medicine (SPMC)</h3>
  <p class="mt-2 text-lg dim">A Portuguese professional association, adopting pretix for their events, starting this year.</p>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead">Proof: the gap doesn't stop it.</p>

<!--
This is not just an idea. <br>PyCon Portugal already runs on pretix. <br>SPMC starts this year. <br>Real events, running today, gap and all.
-->

---
layout: default
timing: 210s
---

# One gap left

<div class="grid grid-cols-2 gap-10 mt-8">

<div>
  <p class="meta">Solved</p>
  <ul class="plain-list mt-2">
    <li>Multibanco</li>
    <li>MB WAY</li>
  </ul>
</div>

<div>
  <p class="meta accent">Still open</p>
  <ul class="plain-list mt-2">
    <li>A Portuguese invoicing plugin - ATCUD, AT communication</li>
  </ul>
</div>

</div>

<div class="rule mt-8"></div>

<p class="lead">If commercial SaaS still wins by default, that's on us - not on the software.</p>

<!--
Payments are solved now. <br>Invoices are still missing. <br>If you know pretix and want to help, please talk to me after this.
-->

---
layout: cover
timing: 245s
---

<p class="meta">Thanks for Listening</p>

# Change the default

<div class="rule"></div>

<p class="lead">One event at a time.</p>

<div class="flex gap-12 mt-10">
  <div>
    <p class="meta">Install</p>
    <p class="mt-1">pip install pretix-eupago</p>
  </div>
  <div>
    <p class="meta">Code</p>
    <p class="mt-1">github.com/afonsosantos/pretix-eupago</p>
  </div>
  <div>
    <p class="meta">Contact</p>
    <p class="mt-1">afonso@afonsosantos.me</p>
  </div>
</div>

<!--
A plugin alone does not change the default. People need to choose it. <br>The plugin is on PyPI, the code is on GitHub. <br>Find me during the conference if you want to talk.
-->
