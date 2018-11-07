import Vue from 'vue'
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#app',
    template: '<App/>',
    components: { App }
  })
})
