<template>
  <div id="app">
    <h2>質問:研究のモチベーションは??</h2>
    <p>{{ message }}</p>
    <input type="text" v-model="message">
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "質問を入力してください"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
