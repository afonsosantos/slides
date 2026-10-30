<script setup>
// Mini-mapa dos passos de um guia, no topo de cada slide de passo: os feitos, o atual e os que faltam.
const props = defineProps({ guia: String, passo: Number })
const guias = {
  instalar: ['Pacote', 'Preparar', 'Extrair', 'Base de dados', 'Migrar', 'Uploads', 'Cache', 'Configuração', 'Testar'],
  atualizar: ['Update', 'Backup', 'Extrair', 'Migrar', 'Cache e testar'],
}
</script>

<template>
  <ol class="trilho">
    <li
      v-for="(nome, i) in guias[props.guia]"
      :key="nome"
      :class="{ feito: i + 1 < props.passo, atual: i + 1 === props.passo }"
    >
      <span class="trilho-num">{{ i + 1 }}</span>{{ nome }}
    </li>
  </ol>
</template>
