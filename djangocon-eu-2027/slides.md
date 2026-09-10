---
theme: default
title: Nobody else is going to write it.
colorSchema: light
layout: cover
timer: countdown
duration: 30min
routerMode: hash
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

<p class="fineprint absolute bottom-10 right-14">Not affiliated with pretix GmbH, euPago or Fact.pt.</p>

<!--
Good morning. <br>Today I want to talk about contributing to open source. <br>Not the idea of it. <br>The actual work.
-->

---
layout: two-cols
timing: 40s
---

# Who am I

<div class="mt-10">
  <p class="meta">Role</p>
  <p class="mt-2 text-2xl">Full Stack Developer</p>

  <p class="meta mt-8">Based in</p>
  <p class="mt-2 text-2xl">Leiria, Portugal</p>

  <img src="/visionsoft-white.svg" class="logo-invert h-7 object-contain mt-10" alt="Visionsoft" />
</div>

::right::

<div class="mt-24 pl-10">
  <p class="meta accent">What I maintain</p>
  <ul class="plain-list mt-3">
    <li><strong>pretix-eupago</strong> — payments</li>
    <li><strong>pretix-factpt</strong> — invoicing</li>
  </ul>
  <div class="rule mt-8"></div>
  <p class="dim">Both on PyPI. Both running real events.</p>
</div>

<!--
I am a full stack developer at Visionsoft, in Portugal. <br>I wrote two plugins for pretix. <br>Both are on PyPI. <br>Both run real events today.
-->

---
layout: quote
timing: 80s
---

# "Find a project you like, and look for a good first issue."

<p class="lead mt-8">Good advice. Wrong direction.</p>

<!--
Everyone gives this advice. <br>Find a project. Look for an easy issue. <br>It sounds right. <br>I think the direction is wrong.
-->

---
layout: default
timing: 120s
---

# Why that rarely works

<div class="grid grid-cols-2 gap-10 mt-10">

<div>
  <p class="meta">What you are doing</p>
  <ul class="plain-list mt-2">
    <li>Shopping for a problem</li>
    <li>Someone else's problem</li>
    <li>On someone else's schedule</li>
  </ul>
</div>

<div>
  <p class="meta accent">What happens</p>
  <ul class="plain-list mt-2">
    <li>It gets boring</li>
    <li>The review takes three weeks</li>
    <li>You stop</li>
  </ul>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead">Nothing was pushing you. So nothing kept you going.</p>

<!--
You go looking for a project that needs help. <br>That is shopping for a problem. <br>It is somebody else's problem. <br>Then it gets boring, and you stop. <br>Nothing was pushing you.
-->

---
layout: statement
timing: 150s
---

<p class="giant-word">BLOCKED.</p>

<p class="lead mt-4">Wait until something stops you.</p>

<!--
The good contribution starts differently. <br>You want to do something. <br>And the software will not let you. <br>That is the moment. <br>Wait for it.
-->

---
layout: default
timing: 210s
---

# What stopped me

<p class="text-lg dim mt-4">I wanted to run a conference without renting closed-source ticketing. pretix was the best fit — almost.</p>

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
timing: 240s
---

# Not a bug. <span class="accent">A plugin nobody wrote.</span>

<p class="lead mt-8 text-center">A bug you report. A missing plugin you write.</p>

<!--
This is important. <br>It was not broken. <br>Nobody had written that plugin yet. <br>A bug you report. <br>A missing plugin you write.
-->

---
layout: section
timing: 250s
---

<p class="meta">Part 01</p>

# Anatomy of a plugin

<div class="rule"></div>

<!--
First: what a pretix plugin actually is.
-->

---
layout: two-cols-header
timing: 300s
---

# pretix, in one slide

<div class="rule"></div>

::left::

<div class="pr-10">
  <p class="meta">What it is</p>
  <ul class="plain-list mt-2">
    <li>Ticketing for conferences and events</li>
    <li>A Django project you can self-host</li>
    <li>AGPL, ~10 years old, used across Europe</li>
  </ul>
</div>

::right::

<div class="pl-4">
  <p class="meta accent">Why it matters here</p>
  <ul class="plain-list mt-2">
    <li>Built to be extended from outside</li>
    <li>Payments, exports, checkout, emails — pluggable</li>
    <li>You never fork it</li>
  </ul>
</div>

<!--
pretix is ticketing software. <br>It is a Django project. <br>You can host it yourself. <br>Most important: it is designed to be extended from outside. <br>You never need to fork it.
-->

---
layout: default
timing: 360s
---

# A plugin is a Django app

<p class="text-lg dim mt-2">There is an official cookiecutter. This is what it gives you.</p>

```text
pretix_eupago/
├── apps.py            # AppConfig + PretixPluginMeta
├── signals.py         # where you hook into pretix
├── payment.py         # your actual code
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
layout: two-cols
timing: 430s
class: code-sm
---

# The metadata

<div class="pr-6 mt-4">

```python
class PluginApp(PluginConfig):
    name = "pretix_eupago"

    class PretixPluginMeta:
        name = _("euPago Payments")
        author = "Afonso Santos"
        version = __version__
        category = "PAYMENT"
        compatibility = "pretix>=4.0.0"

    def ready(self):
        from . import signals  # NOQA
```

</div>

::right::

<div class="pl-8 mt-28">
  <p class="meta accent">Notice</p>
  <ul class="plain-list mt-3">
    <li>A normal Django <code>AppConfig</code></li>
    <li>One nested class pretix reads</li>
    <li>You declare which versions you support</li>
  </ul>
</div>

<!--
This is real code from my plugin. <br>It is a normal Django AppConfig. <br>The nested class tells pretix what this plugin is. <br>Category payment. <br>And which pretix versions it works with.
-->

---
layout: default
timing: 490s
---

# How pretix finds you

```toml
[project.entry-points."pretix.plugin"]
pretix_eupago = "pretix_eupago:PluginApp"
```

<div class="grid grid-cols-2 gap-10 mt-10">

<div>
  <p class="meta">What this is</p>
  <ul class="plain-list mt-2">
    <li>A setuptools entry point</li>
    <li>Scanned by pretix at startup</li>
  </ul>
</div>

<div>
  <p class="meta accent">What you never do</p>
  <ul class="plain-list mt-2">
    <li>Touch <code>INSTALLED_APPS</code></li>
    <li>Patch the host project</li>
  </ul>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead"><code>pip install</code>, restart, tick a box in the event settings.</p>

<!--
This is how pretix discovers the plugin. <br>One entry point in pyproject. <br>The user installs with pip and restarts. <br>Nobody edits settings files. <br>Nobody forks anything.
-->

---
layout: two-cols
timing: 560s
class: code-sm tight-title
---

# Where you hook in

<div class="pr-6 mt-4">

```python
@receiver(register_payment_providers)
def register_payment_provider(sender, **kw):
    from .payment import (
        EupagoMBWAY, EupagoMultibanco,
    )
    return [EupagoMultibanco, EupagoMBWAY]
```

</div>

::right::

<div class="pl-8 mt-20">
  <p class="meta accent">Django signals. That is the whole mechanism.</p>
  <ul class="plain-list mt-4">
    <li><code>register_payment_providers</code></li>
    <li><code>order_paid</code></li>
    <li><code>register_data_exporters</code></li>
    <li><code>nav_event</code></li>
    <li>…and many more</li>
  </ul>
</div>

<!--
And this is how you add something. <br>A Django signal receiver. <br>pretix asks: who provides payment methods? <br>My plugin answers. <br>That is the whole mechanism.
-->

---
layout: center
timing: 620s
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
timing: 630s
---

<p class="meta">Part 02</p>

# Plugin one: payments

<div class="rule"></div>

<!--
Now the first plugin. Payments.
-->

---
layout: default
timing: 700s
---

# Two methods you probably never used

<p class="text-lg dim mt-4">Neither of them is a card. Both of them are how Portugal pays.</p>

<div class="grid grid-cols-2 gap-10 mt-10">

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

<div class="rule mt-10"></div>

<p class="lead">In Portugal these are not extras. People expect them.</p>

<!--
Two payment methods you may not know. <br>Multibanco gives you a reference number. <br>You pay at a cash machine or in your bank app. <br>MB WAY uses your phone number. <br>In Portugal, these are not extras. People expect them.
-->

---
layout: fact
timing: 730s
---

<p class="big-number">4</p>

<p class="lead mt-4">countries, four different defaults.</p>

<div class="grid grid-cols-4 gap-8 mt-10">
  <div>
    <p class="flag">🇵🇹</p>
    <p class="meta mt-2">Portugal</p>
    <p class="mt-2 text-2xl">Multibanco</p>
  </div>
  <div>
    <p class="flag">🇦🇹</p>
    <p class="meta mt-2">Austria</p>
    <p class="mt-2 text-2xl">EPS</p>
  </div>
  <div>
    <p class="flag">🇳🇱</p>
    <p class="meta mt-2">Netherlands</p>
    <p class="mt-2 text-2xl">iDEAL</p>
  </div>
  <div>
    <p class="flag">🇵🇱</p>
    <p class="meta mt-2">Poland</p>
    <p class="mt-2 text-2xl">BLIK</p>
  </div>
</div>

<div class="rule mt-12"></div>

<p class="lead">Every country has its own. <strong>Yours is probably missing.</strong></p>

<!--
And this is not only Portugal. <br>Austria has E P S. <br>The Netherlands has iDEAL. <br>Poland has BLIK. <br>Every country here has one. <br>Yours is probably missing too.
-->

---
layout: default
timing: 800s
---

# The contract

<p class="text-lg dim mt-2">Subclass <code>BasePaymentProvider</code> and fill in what applies.</p>

```python
class EupagoMultibanco(BasePaymentProvider):
    identifier = "eupago_multibanco"
    public_name = _("Multibanco")

    def settings_form_fields(self): ...      # organiser config
    def checkout_confirm_render(self): ...   # what the buyer sees
    def execute_payment(self, request, payment): ...
    def payment_pending_render(self): ...    # "waiting for payment"
    def payment_control_render(self): ...    # what staff see
```

<p class="lead mt-6">Sensible defaults for everything you skip.</p>

<!--
For a payment method you subclass one class. <br>You give it an identifier and a name. <br>Then you fill in the parts you need. <br>Everything you skip has a default. <br>You do not implement fifty methods.
-->

---
layout: default
timing: 880s
class: code-sm
---

# Doing the thing

```python
def execute_payment(self, request, payment: OrderPayment):
    identifier = f"{payment.order.code}-{payment.pk}"

    data = requests.post(MULTIBANCO_URL[self._env()], json={
        "valor": float(payment.amount),
        "id": identifier,
    }, headers={"ApiKey": self._api_key}, timeout=30).json()

    payment.info = json.dumps({
        "referencia": data["referencia"],
        "entidade": data["entidade"],
        "identifier": identifier,
    })
    payment.state = OrderPayment.PAYMENT_STATE_PENDING
    payment.save(update_fields=["info", "state"])
```

<p class="lead mt-5">We asked for a reference. We did <strong>not</strong> get paid.</p>

<!--
Here is the real method, shortened. <br>We call the payment provider. <br>We get back a reference number. <br>We save it on the payment. <br>And we set the state to pending. <br>Nobody has paid yet.
-->

---
layout: statement
timing: 920s
---

<p class="giant-word">LATER.</p>

<p class="lead mt-4">The customer pays hours or days after checkout.</p>

<!--
This is the hard part of payment plugins. <br>With a card, you know immediately. <br>With Multibanco, the person pays later. <br>Maybe tomorrow. <br>Your code has already finished running.
-->

---
layout: default
timing: 1010s
class: code-sm
---

# So the money arrives at a URL

```python
class EupagoWebhookView(View):

    def _confirm_payment(self, payment: OrderPayment):
        if payment.state in (
            OrderPayment.PAYMENT_STATE_CONFIRMED,
            OrderPayment.PAYMENT_STATE_CANCELED,
            OrderPayment.PAYMENT_STATE_REFUNDED,
        ):
            return          # already done — webhooks repeat

        payment.confirm()   # pretix: marks paid, emails, frees quota
```

<p class="lead mt-6">One call. The host owns the state machine — let it.</p>

<!--
So the provider calls a URL on your server. <br>A normal Django view. <br>You find the payment and you call confirm. <br>pretix does the rest. <br>It marks the order paid and sends the email. <br>Do not do that yourself.
-->

---
layout: two-cols-header
timing: 1090s
---

# What I got wrong first

<div class="rule"></div>

::left::

<div class="pr-10">
  <p class="meta">The assumptions</p>
  <ul class="plain-list mt-2">
    <li>The request is who it says it is</li>
    <li>It arrives exactly once</li>
    <li>It arrives after the customer returns</li>
  </ul>
</div>

::right::

<div class="pl-4">
  <p class="meta accent">The fixes</p>
  <ul class="plain-list mt-2">
    <li>Verify the HMAC signature</li>
    <li>Re-check the identifier we stored ourselves</li>
    <li>Return early if already in a terminal state</li>
  </ul>
</div>

<!--
I got three things wrong. <br>I trusted the request. <br>I assumed it comes once. <br>I assumed it comes after the customer returns. <br>All three are wrong. <br>Check the signature. Check your own identifier. And make it safe to call twice.
-->

---
layout: statement
timing: 1120s
---

<p class="lead">A webhook is a public endpoint</p>

# with your customers' <span class="accent">money</span> behind it.

<!--
Remember this. <br>A webhook is a public URL. <br>Anyone can call it. <br>And there is money behind it.
-->

---
layout: section
timing: 1130s
---

<p class="meta">Part 03</p>

# Plugin two: invoicing

<div class="rule"></div>

<!--
Second plugin. Invoices. A very different shape.
-->

---
layout: two-cols-header
timing: 1190s
---

# Portugal does not accept a PDF

<div class="rule"></div>

::left::

<div class="pr-10">
  <p class="meta">A legal invoice needs</p>
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
Second problem: invoices. <br>In Portugal a PDF is not enough. <br>The software must be certified by the state. <br>Every invoice needs a special code and must be reported. <br>The rules change every year.
-->

---
layout: fact
timing: 1250s
---

<p class="big-number">0</p>

<p class="lead mt-6">lines of tax law in my plugin.</p>

<p class="meta mt-10">The best decision I made was not writing code</p>

<!--
Here is the decision I am most happy with. <br>Zero lines of tax law. <br>I did not build certified invoicing. <br>That is not my problem to solve. <br>I connected pretix to a company that already does it.
-->

---
layout: default
timing: 1300s
---

# Know which part is yours

<div class="grid grid-cols-2 gap-10 mt-10">

<div>
  <p class="meta">Not mine</p>
  <ul class="plain-list mt-2">
    <li>Software certification</li>
    <li>ATCUD generation</li>
    <li>Talking to the tax authority</li>
  </ul>
</div>

<div>
  <p class="meta accent">Mine</p>
  <ul class="plain-list mt-2">
    <li>The glue between pretix and a certified provider</li>
    <li>Retries, errors, and a page to see them</li>
  </ul>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead">Scoping the problem down is a contributing skill.</p>

<!--
They handle the law. I handle the glue. <br>Certification is not my problem. <br>My part is small: connect the two, and handle failures. <br>Making the problem smaller is a skill.
-->

---
layout: two-cols
timing: 1360s
class: code-sm tight-title
---

# No provider class

<div class="pr-6 mt-4">

```python
@receiver(order_paid)
def factpt_order_paid(sender, order, **kw):
    # Enqueue only — a slow provider
    # must never delay checkout.
    generate_factpt_invoice.apply_async(
        kwargs={"order_pk": order.pk,
                "event_pk": sender.pk}
    )
```

</div>

::right::

<div class="pl-8 mt-24">
  <p class="meta accent">A different shape</p>
  <ul class="plain-list mt-3">
    <li>One signal: <code>order_paid</code></li>
    <li>One Celery task</li>
    <li>One model of its own</li>
  </ul>
</div>

<!--
This plugin has no payment provider. <br>It listens for one signal: order paid. <br>Then it starts a background task. <br>Never call a slow API during checkout.
-->

---
layout: default
timing: 1420s
class: code-sm
---

# Safe to run twice

```python
@app.task(bind=True, max_retries=3, default_retry_delay=120, acks_late=True)
def generate_factpt_invoice(self, order_pk, event_pk=None):
    invoice, _created = FactptInvoice.objects.get_or_create(
        order=order,
        identifier_id=identifier_id,          # idempotency key
        defaults={"status": FactptInvoice.STATUS_PENDING},
    )
    if invoice.status == FactptInvoice.STATUS_SUCCESS:
        return
```

<p class="lead mt-6">Same idea as the webhook. Retries are not the exception.</p>

<!--
Notice the identifier again. <br>The same idea as the webhook. <br>The task can run twice and nothing breaks. <br>With background jobs, retries are normal, not an accident.
-->

---
layout: two-cols-header
timing: 1490s
---

# Assume it will fail

<div class="rule"></div>

<p class="lead">That control-panel page is half the value of the plugin.</p>

::left::

<div class="pr-10">
  <p class="meta">What goes wrong</p>
  <ul class="plain-list mt-2">
    <li>The provider is down</li>
    <li>A customer typed a bad tax number</li>
    <li>The API changed its response shape</li>
  </ul>
</div>

::right::

<div class="pl-4">
  <p class="meta accent">So the plugin ships with</p>
  <ul class="plain-list mt-2">
    <li>Its own model, storing the error</li>
    <li>A page in the control panel</li>
    <li>A retry button for the organiser</li>
  </ul>
</div>

<!--
It will fail sometimes. <br>The provider goes down. Someone types a wrong tax number. <br>So I store every attempt in my own model. <br>And there is a page where the organiser can see errors and press retry. <br>That page is half the value.
-->

---
layout: section
timing: 1500s
---

<p class="meta">Part 04</p>

# After you ship

<div class="rule"></div>

<!--
Now: what happens after the code works.
-->

---
layout: default
timing: 1560s
---

# Publishing is the easy part

<div class="grid grid-cols-2 gap-10 mt-10">

<div>
  <p class="meta">Package</p>
  <ul class="plain-list mt-2">
    <li>Name it <code>pretix-yourthing</code></li>
    <li>Declare <code>compatibility</code> honestly</li>
    <li>Pick a licence on day one</li>
  </ul>
</div>

<div>
  <p class="meta accent">Publish</p>
  <ul class="plain-list mt-2">
    <li>Trusted publishing from CI, no tokens</li>
    <li>Tag the release, write the changelog</li>
  </ul>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead"><code>pip install pretix-eupago</code> — anyone in Portugal, from that moment on.</p>

<!--
Publishing is simple. <br>Follow the naming convention. <br>Say which pretix versions you support. <br>Choose a licence early. <br>Then upload to PyPI from your CI. <br>After that, anyone can install it.
-->

---
layout: fact
timing: 1610s
---

<p class="big-number">~170</p>

<p class="lead mt-6">plugins on the pretix Marketplace.</p>

<p class="meta mt-10">Official and third-party · free and paid · <span class="accent">euPago is one of them</span></p>

<!--
pretix has a marketplace. <br>About one hundred and seventy plugins. <br>Official ones and community ones. <br>This is where people who host pretix go to look. <br>My plugin is listed there now. <br>PyPI alone has no audience.
-->

---
layout: default
timing: 1660s
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
Look at what other people built. <br>More payment methods. Company logins. Bank imports. <br>Room sharing for attendees. Train tickets. <br>None of this is in the core product. <br>Every one is a person who got blocked and kept going.
-->

---
layout: two-cols-header
timing: 1730s
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
timing: 1780s
---

# Find your own gap

<div class="grid grid-cols-2 gap-10 mt-10">

<div>
  <p class="meta">Ask yourself</p>
  <ul class="plain-list mt-2">
    <li>What did I work around last month?</li>
    <li>What does my country need that the tool ignores?</li>
    <li>What did I copy between two projects?</li>
  </ul>
</div>

<div>
  <p class="meta accent">Upstream or plugin?</p>
  <ul class="plain-list mt-2">
    <li>Everyone needs it → open an issue upstream</li>
    <li>One country, one integration → plugin</li>
    <li>When in doubt, ask before you build</li>
  </ul>
</div>

</div>

<div class="rule mt-10"></div>

<p class="lead">The gap that blocked you is already scoped, already motivated, already tested — by you.</p>

<!--
So: find your own gap. <br>What did you work around last month? <br>What does your country need that the tool ignores? <br>If everybody needs it, talk to the maintainers first. <br>If it is only your country or your workflow, write a plugin. <br>You already know the problem. That is the advantage.
-->

---
layout: cover
timing: 1800s
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
    <img src="/qr-factpt.svg" class="qr mt-3" alt="QR code to github.com/afonsosantos/pretix-factpt" />
    <p class="mt-2 text-sm dim">github.com/afonsosantos/<br>pretix-factpt</p>
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
