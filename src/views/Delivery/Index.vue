<template>
  <BaseIndex title="Tipos de Entregas" subtitle="Controle os tipos de entregas aceitos por seu estabelecimento">
    <div class="d-flex flex-column gap-4">
      <div class="d-flex gap-4 shadow p-3 rounded" v-for="(delivery, key) in deliveries" :key="key">
        <span>{{ delivery.name }}</span>
        <div>
          <span>{{ delivery.minutes }}</span>
          <small>minutos</small>
        </div>
        <div class="d-flex gap-2 ms-auto">
          <button class="btn btn-primary btn-sm" @click="foawjdoiawiodawdwa(delivery)">
            Editar
          </button>
          <BaseButton :loading="loading" class="btn btn-primary btn-sm" @click="active(delivery)">
            {{ delivery.active === false ? 'Ativar' : 'Desativar' }}
          </BaseButton>
        </div>
      </div>
    </div>
    <div class="mt-5" v-if="selectedDelivery">
      <h6>Editar tempo de entrega: {{ selectedDelivery.name }}</h6>
      <input class="form-control" type="text" v-model="value">
      <BaseButton class="btn btn-primary btn-sm" @click="saveDelivery()" :loading="updating">
        Salvar
      </BaseButton>
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
      selectedDelivery: null,
      value: null,
      updating: false
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
    },
    foawjdoiawiodawdwa(delivery) {
      this.selectedDelivery = delivery
    },
    saveDelivery() {
      this.updating = true
      requesFromStore()
        .put(`delivery/${this.selectedDelivery.key}`, { minutes: this.value })
        .then(() => this.selectedDelivery = null, this.load())
        .finally(() => this.updating = false)
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