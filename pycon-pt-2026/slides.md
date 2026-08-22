---
theme: default
title: pretix in Portugal
colorSchema: dark
layout: cover
duration: 5min
timer: countdown
fonts:
  sans: 'Inter'
  serif: 'Fraunces'
  mono: 'JetBrains Mono'
---

<!-- timing: 0s -->

<p class="meta">Lightning Talk · PyCon Portugal 2026 · Aveiro</p>

# pretix in Portugal

<div class="rule"></div>

<p class="lead">Real Payments, Real Invoices, Real Compliance</p>

<p class="meta mt-10">Afonso Santos</p>

<div class="absolute bottom-10 left-14 flex items-center gap-6">
  <img src="/pycon-logo.svg" class="h-7 object-contain" />
  <div class="logo-sep"></div>
  <img src="/visionsoft-logo.svg" class="h-6 object-contain" />
</div>

<p class="fineprint absolute bottom-10 right-14">Not affiliated with or endorsed by pretix GmbH or euPago.</p>

---
layout: default
timing: 30s
---

<!-- timing: 30s -->

# Who am I?

<div class="grid gap-12 mt-6" style="grid-template-columns: 3fr 2fr">

<ul class="plain-list text-lg">
<li>Went looking for an <strong>open-source</strong> ticketing platform for a conference next year — nothing fit Portugal</li>
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
I was hunting for an open-source ticketing platform for a conference we're running next year. There's plenty of closed-source SaaS options out there, but none of them fit what Portugal actually needs — no Multibanco, no proper invoicing. That's what this talk is about.
-->

---
layout: statement
timing: 30s
---

<!-- timing: 30s -->

<img src="/pretix-logo.svg" class="h-9 mx-auto mb-6 object-contain" />

# Enter <span class="accent">pretix</span>

<p class="lead mt-2">Open-source, self-hostable ticketing</p>

<p class="meta mt-6">Django + Python · Plugin-driven · Self-hostable · Used across Europe</p>

<!--
pretix is everything you'd want if you're in this room — open-source, Django-based, and designed to be extended. And that plugin system is the key.
-->

---
layout: default
timing: 30s
---

<!-- timing: 30s -->

# It's already here

<div class="grid grid-cols-2 gap-10 mt-8">

<div>
  <p class="meta">Case 01</p>
  <h3 class="mt-2">PyCon Portugal 2026</h3>
  <p class="mt-2 text-lg dim">You're literally sitting in the room right now.</p>
</div>

<div>
  <p class="meta">Case 02</p>
  <h3 class="mt-2">SPMC</h3>
  <p class="mt-2 text-lg dim">A Portuguese professional association, adopting pretix for their events, starting this year.</p>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead">Two very different organizations. One stack.</p>

<!--
This isn't a proof of concept. PyCon PT runs on pretix today. And SPMC — a Portuguese professional association — will be using it starting this year. The ecosystem is starting to grow here.
-->

---
layout: default
timing: 45s
---

<!-- timing: 45s -->

# What pretix is missing

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

<p class="lead">euPago fills that gap: a PT-native payment gateway. Someone just had to build the bridge.</p>

<!--
Portugal has specific payment habits and legal requirements pretix doesn't cover out of the box — no Multibanco, no MB WAY. euPago is one of the gateways that gives you both. So I built the bridge.
-->

---
layout: two-cols
timing: 60s
---

<!-- timing: 60s -->

# pretix-eupago

<ul class="plain-list mt-6">
<li>Generates Multibanco references per order, automatically</li>
<li>Sends MB WAY push payment requests</li>
<li>Handles async payment confirmation via webhooks</li>
<li>Open-source - Apache 2.0</li>
</ul>

<p class="meta mt-6">github.com/afonsosantos/pretix-eupago</p>

::right::

<div class="h-full flex items-center justify-center">

```bash
pip install pretix-eupago
```

</div>

<!--
One pip install. Multibanco and MB WAY, fully integrated. The plugin handles the entire async flow — from reference generation to webhook confirmation. And it's open source.
-->

---
layout: default
timing: 30s
---

<!-- timing: 30s -->

# What's still missing

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
    <li>ATCUD + AT communication</li>
    <li>A Portuguese invoicing plugin for pretix</li>
  </ul>
</div>

</div>

<div class="rule mt-8"></div>

<p class="lead">This is an open problem. Come find me after.</p>

<!--
Payments are solved. Fiscal compliance is still open — ATCUD, AT communication. If you've dealt with this before, come find me after.
-->

---
layout: cover
timing: 15s
---

<!-- timing: 15s -->

<p class="meta">Thanks for Listening</p>

# Let's talk

<div class="rule"></div>

<p class="lead">Let's make pretix work for Portugal.</p>

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
The plugin is on PyPI, the code is on GitHub, and I'm around all conference. Let's make pretix actually work for Portugal.
-->

<!-- Total: ~4:15 -->
