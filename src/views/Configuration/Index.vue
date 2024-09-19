<template>
  <BaseIndex title="Configurações">
    <form @submit.prevent="onSubmit()">
      <div>
        <label for="">Pedido Minimo</label>
        <input class="form-control" v-model="form.minimum_order_value" type="text">
      </div>
      <div>
        <label for="">Tempo para Entrega</label>
        <input class="form-control" v-model="form.delivery" type="text">
      </div>
      <div>
        <label for="">Tempo para Retidada</label>
        <input class="form-control" v-model="form.withdrawal" type="text">
      </div>
      <button type="submit" class="btn btn-primary mt-3">
        Salvar
      </button>
    </form>
  </BaseIndex>
</template>

<script>
import BaseIndex from '@/components/BaseIndex.vue'

export default {
  components: {
    BaseIndex
  },
  data() {
    return {
      form: {
        minimum_order_value: null,
        delivery: null,
        withdrawal: null
      }
    }
  },
  methods: {
    onSubmit() {
      api.post()
        .then(() => {
          alert('dddddd')
        })
    }
  }
}
</script>