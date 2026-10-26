<script setup>
// Progress strip for the "follow one order" section: the active stage is filled,
// earlier stages are ticked, later ones are faded.
const props = defineProps({ step: { type: Number, required: true } })
const stages = ['Checkout', 'Waiting', 'Paid', 'Invoiced', 'Refunded']
</script>

<template>
  <ol class="order-trail">
    <li
      v-for="(stage, i) in stages"
      :key="stage"
      :class="{ done: i + 1 < props.step, active: i + 1 === props.step }"
    >
      <span class="n">{{ i + 1 < props.step ? '✓' : i + 1 }}</span>
      {{ stage }}
    </li>
  </ol>
</template>
