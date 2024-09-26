<template>
  <BaseIndex title="Editar Endereço da Loja">
    <form @submit.prevent="onSubmit()">
      <div class="row">
        <div class="col-12 col-lg-6">
          <label for="address-cep">CEP</label>
          <input class="form-control" id="address-cep" v-model="address.cep" type="text">
        </div>
        <div class="col-12 col-lg-6">
          <label for="address-street">Rua</label>
          <input class="form-control" id="address-street" v-model="address.street" type="text">
        </div>
        <div class="col-12 col-lg-6">
          <label for="address-number">Número</label>
          <input class="form-control" id="address-number" v-model="address.number" type="text">
        </div>
        <div class="col-12 col-lg-6">
          <label for="address-neighborhood">Bairro</label>
          <input class="form-control" id="address-neighborhood" v-model="address.neighborhood" type="text">
        </div>
        <div class="col-12 col-lg-6">
          <label for="address-complement">Complemento</label>
          <input class="form-control" id="address-complement" v-model="address.complement" type="text">
        </div>
        <div class="col-12 col-lg-6">
          <label for="address-city">Cidade</label>
          <input class="form-control" id="address-city" v-model="address.city" type="text">
        </div>
        <div class="col-12 col-lg-6">
          <label for="address-state">Estado</label>
          <input class="form-control" id="address-state" v-model="address.state" type="text">
        </div>
      </div>
      <BaseButton type="submit" class="btn btn-primary btn-sm mt-3" :loading="submiting">
        Salvar
      </BaseButton>
    </form>
  </BaseIndex>
</template>

<script>
import BaseIndex from '@/components/BaseIndex.vue'
import BaseForm from '@/components/BaseForm.vue'
import { requesFromStore } from '@/js/api.js'
import BaseButton from '@/components/BaseButton.vue';

export default {
  components: {
    BaseIndex,
    BaseForm,
    BaseButton
  },
  data: () => {
    return {
      address: {
        cep: null,
        street: null,
        number: null,
        neighborhood: null,
        complement: null,
        city: null,
        state: null,
      },
      submiting: false
    }
  },
  mounted() {
    this.load()
  },
  methods: {
    load() {
      requesFromStore()
        .get('address')
        .then(({ data }) => {
          this.address = {
            cep: data.address.cep,
            street: data.address.street,
            number: data.address.number,
            neighborhood: data.address.neighborhood,
            complement: data.address.complement,
            city: data.address.city,
            state: data.address.state,
          }
        })
    },
    onSubmit() {
      this.submiting = true
      requesFromStore()
        .post('address', this.address)
        .then(() => this.$router.push({ name: 'address.index' }))
        .catch(err => console.log(err))
        .finally(() => this.submiting = false)
    }
  }
}
</script>