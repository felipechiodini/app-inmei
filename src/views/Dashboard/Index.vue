<template>
  <BaseIndex title="Home">


    
  </BaseIndex>
</template>

<script>
import BaseIndex from '@/components/BaseIndex.vue'
import { requesFromStore } from '@/js/api.js'
import { useStore } from '@/stores/store'
import Chart from 'chart.js/auto'
import { mapState } from 'pinia'
import { nextTick } from 'vue'
import Loading from '@/js/Mixins/Loading'

export default {
  components: {
    BaseIndex,
  },
  mixins: [Loading],
  data: () => {
    return {
      dashboard: null
    }
  },
  computed: {
    ...mapState(useStore, ['store'])
  },
  mounted() {
    this.load()
  },
  methods: {
    load() {
      requesFromStore(this.$route.params.slug)
        .get('home')
        .then(async ({ data }) => {
          this.dashboard = data.dashboard

          await nextTick()
          const ctx = document.getElementById('myChart')
      
          new Chart(ctx, {
              type: 'line',
              data: {
                labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                datasets: [{
                  label: 'Faturamento Diario',
                  data: [12, 19, 3, 5, 2, 3],
                  borderWidth: 1
                }]
              },
              options: {
                scales: {
                  y: {
                    beginAtZero: true
                  }
                }
              }
           });
        })
    }
  }
}
</script>