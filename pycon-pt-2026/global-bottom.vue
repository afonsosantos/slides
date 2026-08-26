<script setup>
import { useNav } from '@slidev/client'
const { currentLayout, currentPage, total } = useNav()
</script>

<template>
  <footer
    v-if="!['cover', 'end'].includes(currentLayout)"
    class="deck-footer absolute bottom-0 right-0 px-14 py-4 pointer-events-none"
  >
    {{ currentPage }} / {{ total }}
  </footer>

  <div
    v-if="!['cover', 'end'].includes(currentLayout)"
    class="absolute bottom-10 left-14 z-10 flex items-center gap-6 pointer-events-none"
  >
    <img src="/pycon-logo.svg" class="h-7 object-contain" alt="PyCon Portugal 2026"/>
    <div class="logo-sep"></div>
    <img src="/visionsoft-white.svg" class="h-6 object-contain" alt="Visionsoft" />
  </div>
</template>
