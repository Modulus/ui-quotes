<template>
  <div class="hello">
    <h1>Generate some quotes!</h1>
    <button v-on:click="getQuote()">Hit me!!!</button><button v-on:click="clear()">Clear</button>
    <div>
        <ul>
          <li v-for="quote in quotes" :key="quote"><span class="quoteText">{{ quote }}</span></li>
        </ul>


    </div>
  </div>
</template>

<script lang="ts">
import { Options, Vue } from 'vue-class-component';

import Filter from 'bad-words'

@Options({
  data: function() {
    return {
      quotes: []
    }
  },
  methods: {
    clear(): void {
      this.quotes = []
      localStorage.setItem("quotes", this.quotes)
    },
    getQuote() : void {
      const url = "http://loremricksum.com/api/?paragraphs=1&quotes=1"

      fetch(url)
      .then(response => response.json())
      .then(data => {
        console.log(data.data)
        const filter = new Filter()
        data.data.forEach( (quote: string) => {
          if (filter.isProfane(quote)){
            console.warn(quote + "# Is profance cleaning up")
            const cleanQuote = filter.clean(quote)
            this.quotes.push(cleanQuote)
          }
          else {
            this.quotes.push(quote);
          }
        });
      localStorage.setItem("quotes", JSON.stringify(this.quotes))

      })
      .catch(error => console.error(error))
    }
  },
  mounted: function() {
    if(localStorage.quotes){
      this.quotes = JSON.parse(localStorage.quotes)
    }
  }
})
export default class Quotes extends Vue {
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  /* display: inline-block; */
  margin: 0 10px;
}
a {
  color: #42b983;
}

.quoteText {
  color: #42b983;
  font-size: 2em;
  font-weight: bold;
}
</style>
