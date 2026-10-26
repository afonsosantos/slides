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

The deck is dark by default. If the projector washes it out, set `colorSchema: light`
in the frontmatter at the top of `slides.md`; the dev server picks it up live. The
dark colours are one `html.dark` block in `style.css`.

Built with [Slidev](https://sli.dev).
