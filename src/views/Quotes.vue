<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png">
    <Quotes />
  </div>
</template>

<script lang="ts">
import { Options, Vue } from 'vue-class-component';
import Quotes from '@/components/Quotes.vue'; // @ is an alias to /src

@Options({
  components: {
    Quotes,
  },
})
export default class Home extends Vue {}
</script>
