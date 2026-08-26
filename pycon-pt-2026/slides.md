---
theme: default
title: Ticketing has a default. It's the wrong one.
colorSchema: dark
layout: cover
duration: 5min
timer: countdown
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
  <img src="/pycon-logo.svg" class="h-7 object-contain" alt="PyCon Portugal 2026" />
  <div class="logo-sep"></div>
  <img src="/visionsoft-white.svg" class="h-6 object-contain" alt="Visionsoft" />
</div>

<p class="fineprint absolute bottom-10 right-14">Not affiliated with or endorsed by pretix GmbH or euPago.</p>

<!--
Everyone here has used a paid, closed platform to buy a ticket. Nobody chose it. It's just the default. Today I want to explain why it should not be.
-->

---
layout: default
timing: 25s
---

# Who am I?

<div class="grid gap-12 mt-6" style="grid-template-columns: 3fr 2fr">

<ul class="plain-list text-lg">
<li>Went looking for an <strong>open-source</strong> ticketing platform for a conference next year - nothing fit Portugal, so I got annoyed enough to fix it</li>
<li>Author of <strong>pretix-eupago</strong>, an open-source payment plugin for the Portuguese market</li>
</ul>

<div class="flex flex-col gap-4 pl-10" style="border-left: 1px solid var(--rule)">
  <div>
    <p class="meta">Name</p>
    <p class="mt-1 text-lg">Afonso Santos</p>
  </div>
  <div>
    <p class="meta">Role</p>
    <p class="mt-1 text-lg">Full Stack Developer</p>
  </div>
  <div>
    <p class="meta">Company</p>
    <img src="/visionsoft-white.svg" class="h-7 object-contain mt-2" alt="Visionsoft" />
  </div>
  <div>
    <p class="meta">Based in</p>
    <p class="mt-1 text-lg">Leiria, Portugal</p>
  </div>
</div>

</div>

<!--
I was looking for an open-source ticketing tool for a conference next year. Nothing fit Portugal well. That search is where this talk comes from.
-->

---
layout: default
timing: 50s
---

# Renting, by default

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
Most events use a paid, closed platform. You pay per ticket, forever. Your data stays on their servers. But open-source options exist too. pretix is one of the best.
-->

---
layout: statement
timing: 65s
---

<p class="giant-word">RENTING.</p>

<p class="lead mt-4">by default.</p>

<!--
Renting. By default. That is the habit we need to break.
-->

---
layout: statement
timing: 85s
---

<img src="/pretix-white.svg" class="h-9 mx-auto mb-6 object-contain" alt="PyCon Portugal 2026" />

# Enter <span class="accent">pretix</span>

<p class="lead mt-2">As good. Often better. And free.</p>

<p class="meta mt-6">Django + Python · Plugin-driven · Self-hostable · Used across Europe</p>

<!--
pretix is as good as the paid platforms. In some ways, it is better. It is open source, built with Django, and easy to extend.
-->

---
layout: default
timing: 105s
---

# What's missing

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
Portugal needs a few specific things: Multibanco, MB WAY, and legal invoices. pretix does not have these yet. That is the real gap - not the quality of the product.
-->

---
layout: default
timing: 140s
---

# Already working

<div class="grid grid-cols-2 gap-10 mt-8">

<div>
  <p class="meta">Case 01</p>
  <h3 class="mt-2">PyCon Portugal</h3>
  <p class="mt-2 text-lg dim">You're literally sitting in the room right now.</p>
</div>

<div>
  <p class="meta">Case 02</p>
  <h3 class="mt-2">SPMC</h3>
  <p class="mt-2 text-lg dim">A Portuguese professional association, adopting pretix for their events, starting this year.</p>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead">Proof the excuse doesn't hold.</p>

<!--
This is not just an idea. PyCon Portugal already runs on pretix. SPMC starts this year. So we know the gap can be closed. Here is how.
-->

---
layout: statement
timing: 150s
---

<p class="giant-word">PROOF.</p>

<p class="lead mt-4">the excuse doesn't hold.</p>

<!--
Proof. The excuse does not hold.
-->

---
layout: default
timing: 175s
---

# I closed one gap

<ul class="plain-list mt-6">
<li>Generates Multibanco references per order, automatically</li>
<li>Sends MB WAY push payment requests</li>
<li>Handles async payment confirmation via webhooks</li>
<li>Open-source - Apache 2.0 - <code>pip install pretix-eupago</code></li>
</ul>

<div class="rule mt-8"></div>

<p class="lead">The plugin isn't the point. The point is: the gap was never the software's fault.</p>

<!--
I built a plugin called pretix-eupago. It adds Multibanco and MB WAY payments. It is open source. But the plugin is not the real point. The real point: these gaps can be solved.
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
Payments are solved now. Invoices are still missing. If you know pretix and want to help, please talk to me after this.
-->

---
layout: statement
timing: 230s
---

<p class="giant-word">ON US.</p>

<p class="lead mt-4">not on the software.</p>

<!--
On us. Not on the software.
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

<div class="absolute bottom-10 left-14 flex items-center gap-6">
  <img src="/pycon-logo.svg" class="h-7 object-contain" alt="PyCon Portugal 2026" />
  <div class="logo-sep"></div>
  <img src="/visionsoft-white.svg" class="h-6 object-contain" alt="Visionsoft" />
</div>

<p class="fineprint absolute bottom-10 right-14">Not affiliated with or endorsed by pretix GmbH or euPago.</p>

<!--
A plugin alone does not change the default. People need to choose it. The plugin is on PyPI, the code is on GitHub. Find me during the conference if you want to talk.
-->

