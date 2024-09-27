<template>
  <BaseIndex title="Tipos de Pagamentos" subtitle="Controle os tipos de pagamentos aceitos por seu estabelecimento">
    <div class="d-flex flex-column gap-4">
      <div class="d-flex shadow p-3 rounded" v-for="(payment, key) in payments" :key="key">
        <td>{{ payment.name }}</td>
        <BaseButton :loading="loading" class="btn btn-primary btn-sm ms-auto" @click="active(payment)">
          {{ payment.active === false ? 'Ativar' : 'Desativar' }}
        </BaseButton>
      </div>
    </div>
  </BaseIndex>
</template>

<script>
import BaseButton from '@/components/BaseButton.vue';
import BaseIndex from '@/components/BaseIndex.vue'
import { requesFromStore } from '@/js/api.js'
import YesNoLabel from '@/js/Mixins/YesNoLabel.js'

export default {
  components: {
    BaseIndex,
    BaseButton
  },
  mixins: [YesNoLabel],
  data: () => {
    return {
      payments: [],
      loading: false
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
      this.loading = true
      requesFromStore()
        .post(`payment/${payment.key}/status`)
        .then(() => payment.active = !payment.active)
        .finally(() => this.loading = false)
    }
  }

}
</script>