<template>
  <BaseIndex title="Tipos de Pagamentos" subtitle="Controle os tipos de pagamentos aceitos por seu estabelecimento">
    <div class="d-flex flex-column">
      <div class="d-flex" v-for="(payment, key) in payments" :key="key">
        <td>{{ payment.name }}</td>
        <button class="btn btn-primary btn-sm" @click="active(payment)">
          {{ payment.active === false ? 'Ativar' : 'Desativar' }}
        </button>
      </div>
    </div>
  </BaseIndex>
</template>

<script>
import BaseIndex from '@/components/BaseIndex.vue'
import { requesFromStore } from '@/js/api.js'
import YesNoLabel from '@/js/Mixins/YesNoLabel.js'

export default {
  components: {
    BaseIndex
  },
  mixins: [YesNoLabel],
  data: () => {
    return {
      payments: []
    }
  },
  mounted() {
    this.load()
  },
  methods: {
    load() {
      requesFromStore()
        .get('payment')
        .then(({ data }) => this.payments = data.payments)
    },
    active(payment) {
      requesFromStore(this.$route.params.slug)
        .post(`payment/${payment.key}/status`)
        .then(() => this.load())
    }
  }

}
</script>