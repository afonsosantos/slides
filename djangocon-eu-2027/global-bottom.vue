<script setup>
import { computed } from 'vue'
import { useNav } from '@slidev/client'
const { currentLayout, currentPage, currentSlideRoute } = useNav()
const onDark = computed(() =>
  currentLayout.value === 'section'
  || String(currentSlideRoute.value?.meta?.slide?.frontmatter?.class ?? '').includes('meme'),
)
</script>

<template>
  <footer
    v-if="!['cover', 'end'].includes(currentLayout)"
    :class="['deck-footer absolute bottom-0 right-0 px-14 py-4 pointer-events-none', onDark ? 'on-dark' : '']"
  >
    {{ currentPage }}
  </footer>
</template>
