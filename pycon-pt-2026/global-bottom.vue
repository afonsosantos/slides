<script setup>
import { useNav } from '@slidev/client'
const { currentLayout, currentPage } = useNav()
</script>

<template>
  <footer
    v-if="!['cover', 'end'].includes(currentLayout)"
    class="deck-footer absolute bottom-0 right-0 px-14 py-4 pointer-events-none"
  >
    {{ currentPage }}
  </footer>
</template>
