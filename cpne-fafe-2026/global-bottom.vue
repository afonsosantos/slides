<script setup>
import { useNav } from '@slidev/client'
const { currentLayout, currentPage } = useNav()
</script>

<template>
  <footer
    v-if="!['cover', 'end', 'image-left', 'image-right'].includes(currentLayout)"
    class="deck-footer absolute bottom-0 right-0 px-12 py-4 pointer-events-none"
  >
    Fafe Eco Rally 2026 · {{ currentPage }}
  </footer>
</template>
