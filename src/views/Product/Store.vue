<template>
  <BaseIndex title="Novo Produto">
    <form class="p-4" @submit.prevent="onSubmit()">
      <div>
        <label for="product-image">Imagem</label>
        <input type="file" class="form-control" id="product-image" @change="onFileChange">
      </div>
      <div class="col-6">
        <label for="product-name">Nome</label>
        <input class="form-control" v-model="form.name" id="product-name" type="text">
      </div>
      <div class="col-6">
        <label for="product-category">Categoria</label>
        <select class="form-select" id="product-category" v-model="form.category_id">
          <option :value="category.id" v-for="(category, key) in categories" :key="key">
            {{ category.name }}
          </option>
        </select>
      </div>
      <div class="col-6">
        <label for="product-description">Descrição</label>
        <textarea class="form-control" v-model="form.description" id="product-description" rows="5"></textarea>
      </div>
      <div>
        <label for="product-price">Preço</label>
        <input type="text" class="form-control" v-model="form.price" id="product-price">
      </div>
      <button type="submit" class="btn btn-primary">
        Salvar
      </button>
    </form>
  </BaseIndex>
</template>

<script>
import BaseIndex from '@/components/BaseIndex.vue'
import BaseForm from '@/components/BaseForm.vue'
import PhotoUploader from '@/components/PhotoUploader.vue'
import { requesFromStore } from '@/js/api.js'

export default {
  components: {
    BaseIndex,
    BaseForm,
    PhotoUploader
  },
  data: () => {
    return {
      form: {
        category_id: null,
        image: null,
        name: null,
        description: null,
        price: null,
      },
      categories: []
    }
  },
  mounted() {
    this.fetchCategories()
  },
  methods: {
    onSubmit() {
      this.submiting = true
      requesFromStore()
        .postForm('product', this.form)
        .then(({ data }) => this.$router.push({ name: 'product.index' }))
        .catch(error => console.log(error))
        .finally(() => this.submiting = false)
    },
    onFileChange(e) {
      this.form.image = e.target.files[0]
    },
    fetchCategories() {
      requesFromStore()
        .get('category/all')
        .then(({ data }) => this.categories = data.categories)
    }
  }
}
</script>