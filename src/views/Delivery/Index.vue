<template>
  <BaseIndex title="Tipos de Entregas" subtitle="Controle os tipos de entregas aceitos por seu estabelecimento">
    <div class="d-flex flex-column gap-4">
      <div class="d-flex shadow p-3 rounded" v-for="(delivery, key) in deliveries" :key="key">
        <td>{{ delivery.name }}</td>
        <div class="d-flex gap-2 ms-auto">
          <BaseButton :loading="loading" class="btn btn-primary btn-sm" @click="active(delivery)">
            {{ delivery.active === false ? 'Ativar' : 'Desativar' }}
          </BaseButton>
        </div>
      </div>
    </div>
  </BaseIndex>
</template>

<script>
import BaseIndex from '@/components/BaseIndex.vue'
import BaseButton from '@/components/BaseButton.vue';
import { requesFromStore } from '@/js/api.js'

export default {
  components: {
    BaseIndex,
    BaseButton
  },
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
    active(delivery) {
      this.loading = true
      requesFromStore()
        .post(`delivery/${delivery.key}/status`)
        .then(() => delivery.active = !delivery.active)
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