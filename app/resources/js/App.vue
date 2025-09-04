<template>
  <footer class="py-16 text-center text-sm text-black dark:text-white/70 flex items-center justify-center gap-2">
    <img 
      src="https://upload.wikimedia.org/wikipedia/commons/9/95/Vue.js_Logo_2.svg" 
      alt="Vue.js Logo" 
      class="w-6 h-6"
    />
    Vue {{ vueVersion }}
  </footer>
</template>

<script>
import { version as vueVersion } from 'vue'

export default {
  data() {
    return {
      vueVersion,
    }
  }
}
</script>
