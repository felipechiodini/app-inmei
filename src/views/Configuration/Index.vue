<template>
  <BaseIndex title="Configurações">
    <form @submit.prevent="onSubmit()">
      <div>
        <label for="">Valor Minimo para Pedidos</label>
        <input class="form-control" v-model="configuration.minimum_order_value" type="int">
      </div>
      <div>
        <label for="">Tempo para Entrega <small>(minutos)</small></label>
        <input class="form-control" v-model="configuration.delivery" type="int">
      </div>
      <div>
        <label for="">Tempo para Retidada <small>(minutos)</small></label>
        <input class="form-control" v-model="configuration.withdrawal" type="int">
      </div>
      <button type="submit" class="btn btn-primary mt-3">
        Salvar
      </button>
    </form>
  </BaseIndex>
</template>

<script>
import BaseIndex from '@/components/BaseIndex.vue'
import { requesFromStore } from '@/js/api'

export default {
  components: {
    BaseIndex
  },
  data() {
    return {
      configuration: {
        minimum_order_value: null,
        delivery: null,
        withdrawal: null
      }
    }
  },
  mounted() {
    this.load()
  },
  methods: {
    load() {
      requesFromStore()
        .get('configuration')
        .then(({ data }) => {
          this.configuration = {
            minimum_order_value: data.configuration.minimum_order_value,
          }
        })
    },
    onSubmit() {
      requesFromStore()
        .post('configuration', this.configuration)
        .then(() => {
          alert('Alterações salvas')
        })
    }
  }
}
</script>