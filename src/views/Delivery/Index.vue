<template>
  <BaseIndex title="Tipos de Pagamentos" subtitle="Controle os tipos de pagamentos aceitos por seu estabelecimento">
    <div class="d-flex flex-column gap-4">
      <div class="d-flex shadow p-3 rounded" v-for="(payment, key) in deliveries" :key="key">
        <td>{{ payment.name }}</td>
        <div class="d-flex gap-2 ms-auto">
          <!-- <BaseButton :loading="loading" class="btn btn-primary btn-sm" @click="active(payment)">
            {{ payment.active === false ? 'Ativar' : 'Desativar' }}
          </BaseButton> -->
        </div>
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
      deliveries: [],
      loading: false,
      selectedPayment: null,
      value: null
    }
  },
  mounted() {
    this.load()
  },
  methods: {
    load() {
      requesFromStore()
        .get('delivery')
        .then(({ data }) => this.deliveries = data.deliveries)
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

<style>

.ddddddddd {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  background-color: #0000005c;
  z-index: 10;
}

</style>