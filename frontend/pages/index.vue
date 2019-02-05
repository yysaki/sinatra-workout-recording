<template>
  <div>
    hello nuxt
    <div>
      {{ fetchData }}
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      fetchData: ''
    }
  },
  async asyncData({ app }) {
    const helloWorld = await app.$axios.$get('http://localhost:4567/')
    return {
      fetchData: helloWorld
    }
  }
}
</script>
