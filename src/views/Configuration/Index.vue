<template>
  <BaseIndex title="Configurações">
    <form @submit.prevent="onSubmit()">
      <div>
        <label for="">Valor Minimo para Pedidos</label>
        <Money3 class="form-control" v-model.lazy="configuration.minimum_order_value" v-money3="config" />
      </div>
      <BaseButton type="submit" class="btn btn-primary btn-sm mt-3">
        Salvar
      </BaseButton>
    </form>
  </BaseIndex>
</template>

<script>
import BaseButton from '@/components/BaseButton.vue'
import BaseIndex from '@/components/BaseIndex.vue'
import { requesFromStore } from '@/js/api'
import { Money3 } from 'v-money3';

export default {
  components: {
    BaseIndex,
    BaseButton,
    Money3
  },
  data() {
    return {
      config: {
        prefix: 'R$ ',
        thousands: '.',
        decimal: ',',
        precision: 2,
        masked: false
      },
      configuration: {
        minimum_order_value: null
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
        .then(() => this.load())
    }
  }
}
</script>