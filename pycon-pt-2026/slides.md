---
theme: default
title: Ticketing has a default. It's the wrong one.
colorSchema: dark
layout: cover
duration: 5min
timer: countdown
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
  <img src="/pycon-logo.svg" class="h-7 object-contain" />
  <div class="logo-sep"></div>
  <img src="/visionsoft-logo.svg" class="h-6 object-contain" />
</div>

<p class="fineprint absolute bottom-10 right-14">Not affiliated with or endorsed by pretix GmbH or euPago.</p>

<!--
Everyone in this room has used a paid, closed-source platform to buy a ticket. Nobody chose that. It's just the default. I'm here to argue it shouldn't be.
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
    <img src="/visionsoft-logo.svg" class="h-7 object-contain mt-2" />
  </div>
  <div>
    <p class="meta">Based in</p>
    <p class="mt-1 text-lg">Leiria, Portugal</p>
  </div>
</div>

</div>

<!--
I was hunting for an open-source ticketing platform for a conference I'm helping to organize next year. That search is where this talk comes from.
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
Most events default to a commercial platform - fees per ticket, closed source, your data on someone else's infrastructure. Open-source alternatives have existed for years. pretix is one of them, and one of the best.
-->

---
layout: statement
timing: 75s
---

<img src="/pretix-logo.svg" class="h-9 mx-auto mb-6 object-contain" />

# Enter <span class="accent">pretix</span>

<p class="lead mt-2">As good. Often better. And free.</p>

<p class="meta mt-6">Django + Python · Plugin-driven · Self-hostable · Used across Europe</p>

<!--
pretix matches, and in places beats, what commercial platforms offer - fully open source, Django-based, and built to be extended.
-->

---
layout: default
timing: 95s
---

# What's missing

<div class="grid grid-cols-2 gap-10 mt-8">

<div>
  <p class="meta">Portugal expects</p>
  <ul class="plain-list mt-2">
    <li>Multibanco references</li>
    <li>MB WAY</li>
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
Portugal has specific payment habits and legal requirements pretix doesn't cover out of the box. That gap - not product quality - is why adoption stopped.
-->

---
layout: default
timing: 130s
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
This isn't a proof of concept. PyCon Portugal runs on pretix today. SPMC starts this year. The gap is closeable - here's what closing it looks like.
-->

---
layout: default
timing: 155s
---

# I closed one gap

<ul class="plain-list mt-6">
<li>Generates Multibanco references per order, automatically</li>
<li>Sends MB WAY push payment requests</li>
<li>Handles async payment confirmation via webhooks</li>
<li>Open-source - Apache 2.0 - <code>pip install pretix-eupago</code></li>
</ul>

<p class="meta mt-6">github.com/afonsosantos/pretix-eupago</p>

<div class="rule mt-8"></div>

<p class="lead">The plugin isn't the point. The point is: the gap was never the software's fault.</p>

<!--
I built pretix-eupago to close the payments gap - Multibanco, MB WAY, all through webhooks, open source. But the plugin isn't the story. The story is that these gaps are just... solvable.
-->

---
layout: default
timing: 190s
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
Payments are solved. Fiscal compliance is still open. If you've dealt with pretix and want to help, come find me after.
-->

---
layout: cover
timing: 215s
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
  <img src="/pycon-logo.svg" class="h-7 object-contain" />
  <div class="logo-sep"></div>
  <img src="/visionsoft-logo.svg" class="h-6 object-contain" />
</div>

<p class="fineprint absolute bottom-10 right-14">Not affiliated with or endorsed by pretix GmbH or euPago.</p>

<!--
The default doesn't change because a plugin exists. It changes because someone picks it instead. The plugin's on PyPI, the code's on GitHub, and I'm around all conference if you want to discuss it.
-->
