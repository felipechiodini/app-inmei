<template>
  <BaseIndex title="Dados do Estabelecimento">
    <form @submit.prevent="onSubmit()">
      <div class="col-12 col-lg-6">
        <label for="nome">Nome da Loja</label>
        <input v-model="form.name" id="nome" class="form-control">
      </div>
      <div class="col-12 col-lg-6">
        <label for="slug">Identificador</label>
        <input disabled v-model="form.slug" id="slug" class="form-control">
      </div>
      <div class="col-12 col-lg-6">
        <label class="d-block">Logo</label>
        <div class="border text-center rounded p-2">
          <img class="image-logo mb-2" :src="store.logo" v-if="imagePreview === null">
          <img class="image-logo mb-2" :src="imagePreview" v-if="imagePreview">
          <input ref="input-file" @change="setFile" type="file" class="d-none">
          <div>
            <button type="button" class="btn btn-info btn-sm me-2" @click="openInputFile()">
              <span class="fas fa-upload"></span>
              Nova Foto
            </button>
          </div>
        </div>
      </div>
      <button type="submit" class="btn btn-primary btn-sm">
        Salvar
      </button>
    </form>
  </BaseIndex>
</template>

<script>
import BaseIndex from '@/components/BaseIndex.vue'
import BaseForm from '@/components/BaseForm.vue'
import BaseButton from '@/components/BaseButton.vue'
import { useStore } from '@/stores/store'
import { mapState } from 'pinia'
import { requesFromStore } from '@/js/api'

export default {
  components: {
    BaseIndex,
    BaseForm,
    BaseButton
  },
  data: () => {
    return {
      currentLogo: null,
      form: {
        name: null,
        slug: null
      },
      fileToUpload: null,
      imagePreview: null
    }
  },
  computed: {
    ...mapState(useStore, ['store']),
  },
  mounted() {
    this.load()
  },
  methods: {
    load() {
      const { store } = new useStore()

      this.currentLogo = store.logo
      this.form = {
        name: store.name,
        slug: store.slug,
      }
    },
    openInputFile() {
      this.$refs['input-file'].click()
    },
    onSubmit() {
      requesFromStore()
        .postForm('store?_method=PUT', { name: this.form.name, logo: this.fileToUpload })
        .then(() => alert('Alterações salvas'))
        .catch(error => console.log(error))
    },
    setFile({ target }) {
      this.fileToUpload = target.files[0]
      this.imagePreview = URL.createObjectURL(target.files[0])
    }
  }
}

</script>

<style scoped>

.image-logo {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 50%;
}

</style>