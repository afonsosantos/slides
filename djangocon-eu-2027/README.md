# Nobody else is going to write it.

Talk (30 min) · DjangoCon Europe 2027 · Innsbruck

Live: https://afonsosantos.github.io/slides/djangocon-eu-2027/

Extends the PyCon Portugal 2026 lightning talk into a talk about contributing to
open source: challenge the closed-SaaS default, then follow one ticket order from
checkout to invoice through `pretix-eupago` (payments) and `pretix-pt-invoicing`
(invoicing). The order's progress strip is `components/OrderTrail.vue`; the full-bleed
beats use http.cat images from `public/`.

## Usage

```sh
bun install
bun run dev    # start dev server
bun run build  # build static site to dist/
```

## Light theme

The deck opens dark (`index.html` seeds the preference on first load) but
`colorSchema` is `auto`, so if the projector washes it out press `d` or click the
sun/moon button in the nav bar, in either the presenter or the audience window.
The choice is remembered per browser. Exports stay light. The dark colours are one
`html.dark` block in `style.css`.

Built with [Slidev](https://sli.dev).
