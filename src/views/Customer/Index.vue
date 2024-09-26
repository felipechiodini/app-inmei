<template>
  <BaseIndex title="Clientes" subtitle="Clientes registrados em sua base">
    <template #buttons>
      <button class="btn btn-primary btn-sm" @click="$router.push({ name: 'customer.store' })">
        Novo Cliente
      </button>
    </template>
    <div class="table-responsive">
      <table class="table">
        <tr>
          <td>Nome</td>
          <td>CPF</td>
          <td>Celular</td>
          <td>Criado em</td>
        </tr>
        <tr v-for="(customer, key) in customers" :key="key">
          <td>
            {{ customer.name }}
          </td>
          <td>
            {{ customer.document }}
          </td>
          <td>
            {{ customer.cellphone }}
          </td>
          <td>
            {{ customer.created_at }}
          </td>
        </tr>
      </table>
    </div>
  </BaseIndex>
</template>

<script>
import BaseIndex from '@/components/BaseIndex.vue'
import BaseTable from '@/components/BaseTable.vue'
import { requesFromStore } from '@/js/api';

export default {
  components: {
    BaseTable,
    BaseIndex
  },
  mounted() {
    this.load()
  },
  data() {
    return {
      customers: []
    }
  },
  methods: {
    load() {
      requesFromStore()
        .get('customer')
        .then(({ data }) => {
          this.customers = data.customers
        })
    }
  }
}
</script>