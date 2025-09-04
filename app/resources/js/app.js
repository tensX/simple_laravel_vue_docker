import { createApp, version as vueVersion } from 'vue';
import App from './App.vue';

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('vue-version');
  if (el) {
    el.textContent = `Vue v${vueVersion}`;
  }
});

createApp(App).mount('#app');