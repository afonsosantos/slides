---
theme: default
title: Nobody else is going to write it.
colorSchema: light
layout: cover
timer: countdown
duration: 30min
routerMode: hash
transition: slide-left
addons:
  - slidev-addon-second-screen
fonts:
  sans: 'Space Grotesk'
  serif: 'Space Grotesk'
  mono: 'JetBrains Mono'
  weights: '400,500,600,700'
---

<p class="meta">Talk · DjangoCon Europe 2027 · Innsbruck</p>

# Nobody else is going to write it.

<div class="rule"></div>

<p class="lead">Two plugins, one Django project, and the gap that made me contribute.</p>

<p class="meta mt-10">Afonso Santos</p>

<div class="absolute bottom-10 left-14 flex items-center gap-6">
  <img src="/pretix-white.svg" class="logo-invert h-8 object-contain" alt="pretix" />
  <div class="logo-sep"></div>
  <img src="/visionsoft-white.svg" class="logo-invert h-6 object-contain" alt="Visionsoft" />
</div>

<p class="fineprint absolute bottom-10 right-14">Not affiliated with pretix GmbH, euPago, Fact.pt or Moloni.</p>

<!--
Good morning. <br>Today I want to talk about contributing to open source. <br>Not the idea of it. <br>The actual work.
-->

---
layout: two-cols-header
timing: 30s
---

# Who am I

<div class="rule"></div>

::left::

<div class="pr-10">
  <p class="meta">Role</p>
  <p class="mt-2 text-2xl">Full Stack Developer</p>
  <img src="/visionsoft-white.svg" class="logo-invert h-6 object-contain mt-2" alt="Visionsoft" />

  <p class="meta" style="margin-top: 3rem">Based in</p>
  <p class="mt-2 text-2xl">Leiria, Portugal</p>
</div>

::right::

<div class="pl-4">
  <p class="meta accent">What I maintain</p>
  <ul class="plain-list mt-3">
    <li><strong>pretix-eupago</strong> — payments</li>
    <li><strong>pretix-pt-invoicing</strong> — invoicing</li>
  </ul>
  <p class="dim mt-2">Both on PyPI. Both running real events.</p>

  <p class="meta mt-8">Also</p>
  <p class="mt-2 text-2xl">Conference organiser</p>
  <p class="dim text-sm">PyCon Portugal · DjangoCon Europe 2027</p>
</div>

<!--
I am a full stack developer at Visionsoft, in Portugal. <br>I also help organise conferences. That matters for this story. <br>I wrote two plugins for pretix. <br>Both are on PyPI. <br>Both run real events today.
-->

---
layout: statement
timing: 60s
---

<p class="ask"><span class="emoji">🙋</span> Hands up if you bought a ticket for a conference this year.</p>

<p class="lead mt-10" v-click>Keep it up if you <strong>chose</strong> the ticketing platform.</p>

<p class="lead mt-4" v-click>Keep it up if you could <strong>read its code</strong>.</p>

<!--
Quick one. Hands up if you bought a ticket for a conference this year. <br>Keep it up if you chose the ticketing platform. <br>Keep it up if you could read its code. <br>Look around.
-->

---
layout: default
timing: 90s
---

# Ticketing has a default

<p class="text-lg dim mt-4">Everyone here has bought a ticket on a closed platform. Nobody chose it.</p>

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
    <li>Code you can read, let alone extend</li>
    <li>A plugin ecosystem you control</li>
  </ul>
</div>

</div>

<div class="rule mt-8"></div>

<p class="lead">The open-source alternative has been sitting there the whole time.</p>

<!--
Ticketing has a default. <br>Everyone here has bought a ticket on a closed platform, and nobody chose it. <br>You pay per ticket, forever. Your data lives on their servers. <br>You cannot read the code, never mind extend it. <br>And the open-source alternative was there the whole time.
-->

---
layout: statement
timing: 110s
---

<p class="giant-word">RENTING.</p>

<p class="lead mt-4">By default.</p>

<!--
Renting. <br>By default. <br>That is the habit I want you to notice.
-->

---
layout: statement
timing: 130s
---

<img src="/pretix-white.svg" class="logo-invert h-12 mx-auto mb-6 object-contain" alt="pretix" />

# Enter <span class="accent">pretix</span>

<p class="lead mt-2">As good. Often better. And free.</p>

<p class="meta mt-6">Django · Self-hostable · AGPL · Plugin-driven · Used across Europe</p>

<!--
pretix is ticketing software. A Django project you can host yourself. <br>As good as the paid platforms. In some ways better. <br>And the important part for today: it is built to be extended from outside. <br>You never fork it.
-->

---
layout: default
timing: 170s
---

# I hit a wall

<p class="text-lg dim mt-4">I wanted to run a conference without renting. pretix was the best fit — almost.</p>

<div class="grid grid-cols-2 gap-10 mt-10">

<div>
  <p class="meta">What pretix shipped</p>
  <ul class="plain-list mt-2">
    <li>Stripe, PayPal, bank transfer</li>
    <li>Generic PDF invoices</li>
  </ul>
</div>

<div>
  <p class="meta accent">What Portugal actually needs</p>
  <ul class="plain-list mt-2">
    <li>Multibanco and MB WAY</li>
    <li>Invoices certified by the tax authority</li>
  </ul>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead">A great product, missing a Portuguese accent.</p>

<!--
I wanted to run a conference. <br>I did not want to rent a closed platform. <br>pretix was the best option. <br>But it did not support how Portugal pays. <br>And it could not make legal invoices here.
-->

---
layout: center
timing: 215s
---

# Not a bug. <span class="accent">A plugin nobody wrote.</span>

<p class="lead mt-8 text-center">A bug you report. A missing plugin you write.</p>

<!--
This is important. <br>It was not broken. <br>Nobody had written that plugin yet. <br>A bug you report. <br>A missing plugin you write.
-->

---
layout: default
timing: 240s
---

# Why contribute, honestly

<div class="grid grid-cols-2 gap-10 mt-10">

<div>
  <p class="meta">The reasons you are given</p>
  <ul class="plain-list mt-2">
    <li>Give something back</li>
    <li>It looks good on your CV</li>
    <li>Find a good first issue</li>
  </ul>
</div>

<div v-click>
  <p class="meta accent">What actually happens</p>
  <ul class="plain-list mt-2">
    <li>Guilt does not ship code</li>
    <li>Nobody hires for a typo fix</li>
    <li>Not your itch. You stop scratching</li>
  </ul>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead" v-click>Nothing was pushing you. So nothing kept you going.</p>

<!--
Let me be honest about the reasons people give. <br>Give back. Good for your CV. Find an easy issue. <br>None of those kept me going. <br>Guilt does not write code. <br>Nobody hires you for a typo fix. <br>And it is not your itch, so you stop scratching. <br>Nothing was pushing you.
-->

---
layout: statement
timing: 300s
---

<p class="giant-word">BLOCKED.</p>

<p class="lead mt-4">You are not looking for a project that needs help.<br>You are looking for the thing that stopped you.</p>

<!--
The good contribution starts differently. <br>You want to do something. <br>And the software will not let you. <br>You are not looking for a project that needs help. <br>You are looking for the thing that stopped you. <br>That is the moment.
-->

---
layout: section
timing: 335s
---

<p class="meta">Part 01</p>

# Anatomy of a plugin

<div class="rule"></div>

<!--
First: what a pretix plugin actually is. Briefly.
-->

---
layout: default
timing: 350s
---

# A plugin is a Django app

<p class="text-lg dim mt-2">There is an official cookiecutter. This is what it gives you.</p>

```text
pretix_eupago/
├── apps.py            # AppConfig + PretixPluginMeta
├── signals.py         # where you hook into pretix
├── payment.py         # your actual code
├── views.py           # normal Django views
├── urls.py            # normal Django URLs
├── templates/
└── locale/
pyproject.toml         # + one entry point
```

<p class="lead mt-6">Nothing new to learn. It is an app, plus metadata.</p>

<!--
A plugin is just a Django app. <br>There is a cookiecutter to start. <br>You already know every file here. <br>The only new parts are the metadata and the signals.
-->

---
layout: two-cols-header
timing: 420s
class: code-sm
---

# How pretix finds you, and how you answer

<div class="rule"></div>

::left::

<div class="pr-8">
  <p class="meta">pyproject.toml</p>

```toml
[project.entry-points."pretix.plugin"]
pretix_eupago = "pretix_eupago:PluginApp"
```

  <p class="meta mt-6">pretix_eupago/signals.py</p>

```python
@receiver(register_payment_providers)
def register_payment_provider(sender, **kw):
    from .payment import EupagoMBWAY, EupagoMultibanco
    return [EupagoMultibanco, EupagoMBWAY]
```

</div>

::right::

<div class="pl-4">
  <p class="meta accent">That is the whole mechanism</p>
  <ul class="plain-list mt-3">
    <li>An entry point, scanned at startup</li>
    <li>Django signals: payments, exports, emails, backend pages</li>
    <li>Never touch <code>INSTALLED_APPS</code>. Never fork</li>
  </ul>
  <p class="dim mt-4"><code>pip install</code>, restart, tick a box.</p>
</div>

<!--
Two pieces. <br>One entry point in pyproject. pretix scans it at startup. <br>And Django signals. pretix asks: who provides payment methods? My plugin answers. <br>That is the whole mechanism. <br>The user installs with pip and restarts. Nobody edits settings. Nobody forks.
-->

---
layout: center
timing: 500s
---

# The rest is just Django

<div class="rule mx-auto mt-8"></div>

<p class="text-xl dim mt-6 text-center leading-relaxed">
Templates · Forms · Models and migrations · Class-based views · URLs<br />
Per-event permissions · <code>gettext</code> · Celery tasks · pytest
</p>

<p class="lead mt-10 text-center">The barrier to entry is lower than it looks. That is the point.</p>

<!--
Everything else is normal Django. <br>Templates. Forms. Models. Views. Permissions. Translations. <br>If you write Django, you can write this. <br>The barrier is much lower than people think.
-->

---
layout: section
timing: 540s
---

<p class="meta">Part 02</p>

# Follow one order

<div class="rule"></div>

<p class="lead">From "place order" to a legal invoice, through both plugins.</p>

<!--
Now let's follow one order through both plugins. <br>Someone buys a ticket to a conference. <br>We go from "place order" all the way to a legal invoice.
-->

---
layout: default
timing: 560s
---

# First, the buyer picks how to pay

<p class="text-lg dim mt-2">Neither option is a card. Both are how Portugal pays.</p>

<div class="grid grid-cols-2 gap-10 mt-8">

<div>
  <p class="meta">Multibanco</p>
  <ul class="plain-list mt-2">
    <li><strong>Entity code</strong> + <strong>reference number</strong></li>
    <li>Pay at any ATM or banking app</li>
    <li>Reference stays valid for days</li>
  </ul>
</div>

<div>
  <p class="meta accent">MB WAY</p>
  <ul class="plain-list mt-2">
    <li>Type your <strong>phone number</strong></li>
    <li>Your bank app buzzes</li>
    <li>Confirm — done in seconds</li>
  </ul>
</div>

</div>

<div class="rule mt-8"></div>

<p class="lead">In Portugal these are not extras. People expect them.</p>

<!--
The buyer picks how to pay. <br>Multibanco gives you a reference number. You pay at a cash machine or in your bank app. <br>MB WAY uses your phone number. Your bank app buzzes, you confirm. <br>In Portugal, these are not extras. People expect them.
-->

---
layout: fact
timing: 605s
---

<p class="big-number">4</p>

<p class="lead mt-4">countries, four different defaults.</p>

<div class="grid grid-cols-4 gap-8 mt-10">
  <div>
    <p class="flag">🇵🇹</p>
    <p class="meta mt-2">Portugal</p>
    <p class="mt-2 text-2xl">MB WAY</p>
  </div>
  <div v-click>
    <p class="flag">🇦🇹</p>
    <p class="meta mt-2">Austria</p>
    <p class="mt-2 text-2xl">EPS</p>
  </div>
  <div v-click>
    <p class="flag">🇳🇱</p>
    <p class="meta mt-2">Netherlands</p>
    <p class="mt-2 text-2xl">iDEAL</p>
  </div>
  <div v-click>
    <p class="flag">🇵🇱</p>
    <p class="meta mt-2">Poland</p>
    <p class="mt-2 text-2xl">BLIK</p>
  </div>
</div>

<div class="rule mt-10"></div>

<p class="ask" v-click><span class="emoji">🙋</span> Hands up if your country has one. Keep it up if your favourite tool supports it.</p>

<!--
And this is not only Portugal. <br>Austria, you have E P S. Netherlands, iDEAL. Poland, BLIK. <br>Hands up if your country has one of these. <br>Keep it up if your favourite tool supports it. <br>See? Yours is probably missing too.
-->

---
layout: default
timing: 640s
---

# Checkout

<OrderTrail :step="1" />

<p class="text-lg dim">One class, <code>BasePaymentProvider</code>. Every box is a method on it. pretix owns the pages in between.</p>

<div class="flex items-stretch gap-3 mt-6">
  <div class="flex-1 min-w-0 rounded-lg px-3 py-4" style="background: var(--card)">
    <p class="meta">1 · Pick</p>
    <p class="mt-3 text-xs"><code>payment_form_fields</code></p>
    <p class="mt-2 dim">Type your phone number</p>
  </div>
  <div class="self-center text-2xl dim" v-click="1">→</div>
  <div class="flex-1 min-w-0 rounded-lg px-3 py-4" style="background: var(--card)" v-click="1">
    <p class="meta">2 · Confirm</p>
    <p class="mt-3 text-xs"><code>checkout_confirm_render</code></p>
    <p class="mt-2 dim">"We will ping 912 345 678"</p>
  </div>
  <div class="self-center text-2xl dim" v-click="2">→</div>
  <div class="flex-1 min-w-0 rounded-lg px-3 py-4" style="background: var(--accent-soft)" v-click="2">
    <p class="meta accent">3 · Place order</p>
    <p class="mt-3 text-xs"><code>execute_payment</code></p>
    <p class="mt-2 dim">One API call. Phone buzzes</p>
  </div>
  <div class="self-center text-2xl dim" v-click="3">→</div>
  <div class="flex-1 min-w-0 rounded-lg px-3 py-4" style="background: var(--card)" v-click="3">
    <p class="meta">4 · Wait</p>
    <p class="mt-3 text-xs"><code>payment_pending_render</code></p>
    <p class="mt-2 dim">"Go on, approve it"</p>
  </div>
</div>

<div class="rule mt-6"></div>

<p class="lead" v-click="4">Everything you skip has a default. Multibanco skips box 1 entirely.</p>

<!--
Step one, checkout. <br>A payment method is one class. You fill in the methods you need. Everything else has a default. <br>The buyer types a phone number. That is a form field. <br>They confirm, I render one sentence. <br>They place the order. I make one API call, their phone buzzes, and the payment is pending. <br>Then they wait. <br>Multibanco needs no input from the buyer, so it skips the first box.
-->

---
layout: default
timing: 700s
class: meme
---

<img src="/http-cat-102.jpg" class="meme-img" alt="HTTP 102 Processing, illustrated by a cat" />

<div class="meme-text">
  <p class="giant-word">LATER.</p>
  <div class="rule"></div>
  <p class="lead">The buyer pays in an hour. Or on Thursday.</p>
</div>

<!--
This is the hard part of payment plugins. <br>With a card, you know immediately. <br>With Multibanco, the person pays later. In an hour. Or on Thursday. <br>Your code finished running long ago.
-->

---
layout: default
timing: 730s
---

# Waiting

<OrderTrail :step="2" />

<div class="grid grid-cols-2 gap-10 mt-2">

<div>
  <p class="meta">Meanwhile, in pretix</p>
  <ul class="plain-list mt-2">
    <li>The order page shows the reference</li>
    <li>The reference goes out by email</li>
    <li>Unpaid for too long? pretix expires the order</li>
  </ul>
</div>

<div>
  <p class="meta accent">Meanwhile, in my plugin</p>
  <ul class="plain-list mt-2">
    <li>Nothing. It is not running</li>
    <li>No polling, no cron, no state of its own</li>
    <li>Just one URL, waiting</li>
  </ul>
</div>

</div>

<div class="rule mt-8"></div>

<p class="lead">The host owns the state machine. Let it.</p>

<!--
While the buyer is away, pretix does the waiting. <br>The order page shows the reference. It goes out by email. <br>If nobody pays, pretix expires the order and frees the ticket. <br>My plugin does nothing. It is not running. No polling, no cron. <br>Just one URL, waiting.
-->

---
layout: default
timing: 770s
class: code-sm
---

# Paid

<OrderTrail :step="3" />

<p class="text-lg dim">The provider calls that URL. A normal Django view.</p>

```python
class EupagoWebhookView(View):
    def post(self, request):
        payment = self._lookup_payment(request)   # our identifier, our signature check
        payment.confirm()                         # pretix: marks paid, emails, frees quota
        return HttpResponse("OK")
```

<div class="rule mt-6"></div>

<p class="lead">One call. pretix does the rest, and fires <code>order_paid</code> for whoever is listening.</p>

<!--
Step three. The buyer approves, and euPago calls my URL. <br>A normal Django view. I find the payment, check it is really euPago, and call confirm. <br>pretix marks the order paid, sends the ticket, frees the quota. <br>And it fires a signal: order paid. Remember that signal. Someone is listening.
-->

---
layout: default
timing: 810s
class: meme
---

<img src="/http-cat-200.jpg" class="meme-img" alt="HTTP 200 OK, illustrated by a cat" />

<div class="meme-text">
  <p class="giant-word">PAID.</p>
  <div class="rule"></div>
  <p class="lead">Usually.</p>
</div>

<!--
Paid. <br>Usually.
-->

---
layout: default
timing: 825s
class: meme
---

<img src="/http-cat-409.jpg" class="meme-img" alt="HTTP 409 Conflict, illustrated by a cat" />

<div class="meme-text">
  <p class="giant-word">NOTHING ARRIVES IN ORDER.</p>
  <div class="rule"></div>
  <p class="lead">Webhooks repeat, race, and show up early.</p>
</div>

<!--
Because nothing arrives in order. <br>Webhooks repeat. They race the buyer's browser. They show up before they should.
-->

---
layout: two-cols-header
timing: 845s
---

# Things that actually showed up

<OrderTrail :step="3" />

<p class="lead">Never trust the order of events. Read the state.</p>

::left::

<div class="pr-10">
  <ul class="plain-list">
    <li v-click="1"><strong>Paid</strong> before the buyer's page reloaded<br><span class="dim">Fine. The page reads <code>payment.state</code></span></li>
    <li v-click="2"><strong>Paid</strong> after the buyer switched method<br><span class="dim">Confirm anyway. The money is real</span></li>
  </ul>
</div>

::right::

<div class="pl-4">
  <ul class="plain-list">
    <li v-click="3"><strong>Cancel</strong> after Paid<br><span class="dim">pretix ignores it. Thanks, pretix</span></li>
    <li v-click="4"><strong>Refund</strong> before Paid<br><span class="dim">Excuse me? <code>409</code>. euPago retries later</span></li>
  </ul>
</div>

<!--
The webhook can land before the buyer's page has even reloaded. The pending page just reads the state, so it does not matter. <br>Paid can arrive after the buyer gave up and switched method. I confirm anyway. The money is real. <br>A cancel can arrive after a paid. pretix's own fail method ignores that. <br>And a refund can arrive before the payment itself. Excuse me? <br>I answer four-oh-nine, and euPago sends it again later. <br>Never trust the order of events. Read the state.
-->

---
layout: statement
timing: 885s
---

<p class="lead">A webhook is a public endpoint</p>

# with your customers' <span class="accent">money</span> <span class="flag" style="font-size: 0.9em">💸</span> behind it.

<p class="text-xl dim mt-8">Verify the signature · Check the identifier you stored yourself · Make it safe to call twice</p>

<!--
Remember this. <br>A webhook is a public URL. Anyone can call it. And there is money behind it. <br>I got three things wrong at first. I trusted the request. I assumed it comes once. I assumed it comes in order. <br>Check the signature. Check your own identifier. And make it safe to call twice.
-->

---
layout: two-cols-header
timing: 915s
---

# Invoiced. Not so fast.

<OrderTrail :step="4" />

::left::

<div class="pr-10">
  <p class="meta">A legal invoice in Portugal needs</p>
  <ul class="plain-list mt-2">
    <li>State-certified invoicing software</li>
    <li>An ATCUD code and a QR code</li>
    <li>Reporting to the tax authority</li>
  </ul>
</div>

::right::

<div class="pl-4">
  <p class="meta accent">Which means</p>
  <ul class="plain-list mt-2">
    <li>Certification, per vendor</li>
    <li>Rules that change every year</li>
    <li>Real legal risk if you are wrong</li>
  </ul>
</div>

<!--
The order is paid. Now it needs an invoice. <br>In Portugal a PDF is not enough. <br>The software must be certified by the state. Every invoice needs a special code and must be reported. <br>The rules change every year. Get it wrong and it is a legal problem, not a bug.
-->

---
layout: fact
timing: 960s
---

<p class="ask"><span class="emoji">🤔</span> Guess: how many lines of Portuguese tax law are in my plugin?</p>

<p class="big-number mt-8" v-click>0</p>

<p class="text-xl dim mt-6" v-click>Certified providers handle the law. I handle the glue.</p>

<p class="meta mt-8" v-click>Knowing which part is yours is a contributing skill</p>

<!--
Guess. How many lines of Portuguese tax law are in my plugin? <br>Shout a number. <br>Zero. <br>I did not build certified invoicing. That is not my problem to solve. <br>I connected pretix to companies that already do it. They handle the law. I handle the glue. <br>Making the problem smaller is a skill.
-->

---
layout: default
timing: 1000s
---

# Invoiced

<OrderTrail :step="4" />

<p class="text-lg dim">Remember <code>order_paid</code>? Plugin two was listening. It never calls a tax API during checkout.</p>

<div class="flex items-stretch gap-4 mt-6">
  <div class="flex-1 rounded-lg px-5 py-4" style="background: var(--card)">
    <p class="meta">pretix</p>
    <p class="mt-3 text-xl">Fires <code>order_paid</code></p>
  </div>
  <div class="self-center text-3xl dim" v-click="1">→</div>
  <div class="flex-1 rounded-lg px-5 py-4" style="background: var(--accent-soft)" v-click="1">
    <p class="meta accent">pretix-pt-invoicing</p>
    <p class="mt-3 text-xl">Enqueues a Celery task</p>
    <p class="mt-1 text-xl">Writes one row: pending</p>
  </div>
  <div class="self-center text-3xl dim" v-click="2">→</div>
  <div class="flex-1 rounded-lg px-5 py-4" style="background: var(--card)" v-click="2">
    <p class="meta">Fact.pt or Moloni</p>
    <p class="mt-3 text-xl">Issues the invoice</p>
    <p class="mt-1 text-xl">Row: issued. Email sent</p>
  </div>
</div>

<div class="rule mt-6"></div>

<p class="lead" v-click="3">Each provider is a folder with three methods: <strong>issue</strong>, <strong>credit</strong>, <strong>download</strong>.</p>

<!--
Remember the signal? Plugin two was listening. <br>It does not call anyone. It enqueues a Celery task and writes one row: pending. Never call a tax API during checkout. <br>The task picks the provider the organiser chose. Fact.pt or Moloni. <br>Same trick pretix played on me: each provider is a folder with three methods. Issue, credit, download. <br>The invoice is issued, the row says issued, the buyer gets an email.
-->

---
layout: default
timing: 1050s
class: meme
---

<img src="/http-cat-503.jpg" class="meme-img" alt="HTTP 503 Service Unavailable, illustrated by a cat" />

<div class="meme-text">
  <p class="giant-word">ASSUME IT WILL FAIL.</p>
  <div class="rule"></div>
  <p class="lead">The tax provider is down. On launch day. Obviously.</p>
</div>

<!--
And assume it will fail. <br>The provider goes down. On launch day. Obviously.
-->

---
layout: two-cols-header
timing: 1065s
---

# When it fails

<OrderTrail :step="4" />

::left::

<div class="pr-10">
  <p class="meta">What goes wrong</p>
  <ul class="plain-list mt-2">
    <li>The provider is down</li>
    <li>A customer typed a bad tax number</li>
    <li>A timeout. Did the invoice land or not?</li>
  </ul>
</div>

::right::

<div class="pl-4">
  <p class="meta accent">So the plugin ships with</p>
  <ul class="plain-list mt-2">
    <li>That row, storing every attempt and error</li>
    <li>A control-panel page with a retry button</li>
    <li>Retries only where the provider dedupes. Two invoices is worse than none</li>
  </ul>
</div>

<!--
The provider goes down. Someone types a wrong tax number. A request times out and you do not know if the invoice exists. <br>So that row stores every attempt and every error. <br>There is a page where the organiser sees it and presses retry. That page is half the value of the plugin. <br>And I only retry automatically when the provider rejects duplicates. <br>Two official invoices is worse than waiting for a human.
-->

---
layout: default
timing: 1110s
---

# Refunded

<OrderTrail :step="5" />

<p class="text-lg dim">Months later, the buyer cannot come. The organiser refunds in euPago's back office.</p>

<div class="flex items-stretch gap-3 mt-6">
  <div class="flex-1 rounded-lg px-4 py-4" style="background: var(--card)">
    <p class="meta">euPago</p>
    <p class="mt-3 text-lg">Webhook says <strong>Refund</strong></p>
  </div>
  <div class="self-center text-2xl dim" v-click="1">→</div>
  <div class="flex-1 rounded-lg px-4 py-4" style="background: var(--accent-soft)" v-click="1">
    <p class="meta accent">pretix-eupago</p>
    <p class="mt-3 text-lg">Records an external refund</p>
  </div>
  <div class="self-center text-2xl dim" v-click="2">→</div>
  <div class="flex-1 rounded-lg px-4 py-4" style="background: var(--card)" v-click="2">
    <p class="meta">pretix</p>
    <p class="mt-3 text-lg">Organiser confirms it</p>
  </div>
  <div class="self-center text-2xl dim" v-click="3">→</div>
  <div class="flex-1 rounded-lg px-4 py-4" style="background: var(--accent-soft)" v-click="3">
    <p class="meta accent">pretix-pt-invoicing</p>
    <p class="mt-3 text-lg">Issues the credit note</p>
  </div>
</div>

<div class="rule mt-6"></div>

<p class="lead" v-click="4">Neither plugin knows the other exists. pretix is the contract.</p>

<!--
Last step. Months later the buyer cannot come, and the organiser refunds in euPago's back office. <br>euPago calls my webhook. I record the refund in pretix. <br>The organiser confirms it. <br>The invoicing plugin sees the refund is done, and issues a credit note. <br>Neither plugin imports the other. <br>pretix is the contract between them.
-->

---
layout: section
timing: 1160s
---

<p class="meta">Part 03</p>

# After you ship

<div class="rule"></div>

<!--
Now: what happens after the code works.
-->

---
layout: fact
timing: 1180s
---

<p class="ask"><span class="emoji">🤔</span> Guess: how many plugins are on the pretix Marketplace?</p>

<p class="big-number mt-8" v-click>~170</p>

<p class="lead mt-4" v-click>Official and community, free and paid. euPago is one of them.</p>

<div class="grid grid-cols-3 gap-8 mt-8 text-left" v-click>
  <div>
    <p class="meta">Name it</p>
    <p class="mt-2"><code>pretix-yourthing</code></p>
  </div>
  <div>
    <p class="meta">Publish it</p>
    <p class="mt-2">Trusted publishing from CI. No tokens.</p>
  </div>
  <div>
    <p class="meta">List it</p>
    <p class="mt-2">PyPI alone has no audience.</p>
  </div>
</div>

<!--
Guess: how many plugins on the pretix Marketplace? Shout. <br>About one hundred and seventy. Official and community, free and paid. Mine is one of them. <br>Publishing is the easy part. Follow the naming convention. Upload to PyPI from CI, with trusted publishing. <br>Then list it on the Marketplace. That is where people who host pretix go to look. PyPI alone has no audience.
-->

---
layout: default
timing: 1240s
---

# You are not the first

<p class="text-lg dim mt-2">Plugins other people were blocked enough to write:</p>

<div class="grid grid-cols-2 gap-10 mt-8">

<div>
  <ul class="plain-list mt-2">
    <li><strong>iyzico</strong>, <strong>SumUp</strong> — local payments</li>
    <li><strong>OpenID Connect</strong> login</li>
    <li><strong>UIC Barcode</strong> — railway tickets</li>
  </ul>
</div>

<div>
  <ul class="plain-list mt-2">
    <li><strong>Stay22</strong> — accommodation near the venue</li>
    <li><strong>Roomsharing</strong> — attendees share a room</li>
    <li><strong>Matrix Inviter</strong> — invite ticket holders</li>
  </ul>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead">None of this belongs in the core product. All of it exists.</p>

<!--
Look at what other people built. <br>More payment methods. Company logins. Train tickets. <br>Room sharing for attendees. <br>None of this is in the core product. <br>Every one is a person who got blocked and kept going.
-->

---
layout: two-cols-header
timing: 1300s
---

# The unglamorous part

<div class="rule"></div>

<p class="lead">Writing the plugin is a weekend. Maintaining it is the contribution.</p>

::left::

<div class="pr-10">
  <p class="meta">What it costs</p>
  <ul class="plain-list mt-2">
    <li>The host releases; you test again</li>
    <li>The payment API changes silently</li>
    <li>Issues from strangers, at night</li>
  </ul>
</div>

::right::

<div class="pl-4">
  <p class="meta accent">What makes it survivable</p>
  <ul class="plain-list mt-2">
    <li>Tests against a real pretix</li>
    <li>CI on every version you support</li>
    <li>Log everything the provider sends</li>
  </ul>
</div>

<!--
Be honest about the cost. <br>pretix releases a new version, you test again. <br>The payment company changes the API without telling you. <br>People open issues at night. <br>Tests make this survivable. <br>Writing it takes a weekend. Keeping it alive is the real work.
-->

---
layout: default
timing: 1380s
---

# Find your own gap

<p class="ask mt-2"><span class="emoji">📣</span> Thirty seconds. Tell the person next to you what you worked around last month.</p>

<div class="grid grid-cols-2 gap-10 mt-8">

<div v-click>
  <p class="meta">That thing is your gap if</p>
  <ul class="plain-list mt-2">
    <li>You worked around it more than once</li>
    <li>The tool ignores what your country needs</li>
    <li>You copied it between two projects</li>
  </ul>
</div>

<div v-click>
  <p class="meta accent">Upstream or plugin?</p>
  <ul class="plain-list mt-2">
    <li>Everyone needs it → an issue upstream</li>
    <li>One country, one integration → plugin</li>
    <li>When in doubt, ask before you build</li>
  </ul>
</div>

</div>

<div class="rule mt-8"></div>

<p class="lead" v-click>Your gap is already scoped, already motivated, already tested — by you.</p>

<!--
Thirty seconds. Turn to the person next to you and tell them one thing you worked around last month. Go. <br>... <br>That thing is your gap, if you worked around it more than once, if your country needs it, if you copied it between projects. <br>If everybody needs it, talk to the maintainers first. <br>If it is only your country or your workflow, write a plugin. <br>You already know the problem. That is the advantage.
-->

---
layout: statement
timing: 1460s
---

<p class="lead">Two plugins later, the conference runs on pretix.</p>

# Change the <span class="accent">default.</span>

<p class="lead mt-6">If closed SaaS still wins by default, that is on us. Not on the software.</p>

<!--
Two plugins later, the conference runs on pretix. <br>The gap was never the software's fault. <br>If renting still wins by default, that is on us. <br>Change the default. One event at a time.
-->

---
layout: cover
timing: 1520s
---

<p class="meta">Thanks for listening</p>

# Nobody else is going to write it.

<div class="rule"></div>

<p class="lead">So it may as well be you.</p>

<div class="flex gap-16 mt-8">
  <div>
    <p class="meta">Payments</p>
    <img src="/qr-eupago.svg" class="qr mt-3" alt="QR code to github.com/afonsosantos/pretix-eupago" />
    <p class="mt-2 text-sm dim">github.com/afonsosantos/<br>pretix-eupago</p>
  </div>
  <div>
    <p class="meta">Invoicing</p>
    <img src="/qr-pt-invoicing.svg" class="qr mt-3" alt="QR code to github.com/afonsosantos/pretix-pt-invoicing" />
    <p class="mt-2 text-sm dim">github.com/afonsosantos/<br>pretix-pt-invoicing</p>
  </div>
  <div>
    <p class="meta">Contact</p>
    <img src="/qr-contact.svg" class="qr mt-3" alt="QR code to afonso@afonsosantos.me" />
    <p class="mt-2 text-sm dim">afonso@afonsosantos.me</p>
  </div>
</div>

<!--
Both plugins are open source. <br>The links are here. <br>If you want to write one for your country, find me during the conference. <br>Thank you.
-->
