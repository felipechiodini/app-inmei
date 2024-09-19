<template>
  <BaseIndex title="Configurações">
    <form @submit.prevent="onSubmit()">
      <label for="">Pedido Minimo</label>
      <input class="form-control" type="text">

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