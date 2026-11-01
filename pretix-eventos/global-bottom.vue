<script setup>
import { useNav } from '@slidev/client'
const { currentLayout, currentPage } = useNav()
</script>

<template>
  <span
    v-if="!['cover', 'end'].includes(currentLayout)"
    class="deck-footer fixed bottom-4 left-14 pointer-events-none"
  >
    Bilheteira · Pagamentos · Faturação
  </span>
  <footer
    v-if="!['cover', 'end'].includes(currentLayout)"
    class="deck-footer absolute bottom-0 right-0 px-14 py-4 pointer-events-none"
  >
    {{ currentPage }}
  </footer>
</template>
