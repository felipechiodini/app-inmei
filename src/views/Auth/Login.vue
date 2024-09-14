<template>
  <TemplateLogin>
    <div class="d-flex flex-column justify-content-center h-100 px-4">
      <img width="150px" src="/logo.png">
      <h1>Login</h1>
      <p>Acesse sua conta para gerenciar sua loja.</p>
      <form class="d-flex flex-column" novalidate @submit.prevent="onSubmit()">
        <label for="login-email">Email</label>
        <BaseInput required id="login-email" type="email" v-model="form.email" />
        <BaseError>{{ errors.get('email') }}</BaseError>
        <label for="login-password" class="mt-2">Senha</label>
        <BaseInput required id="login-password" type="password" v-model="form.password" />
        <BaseError>{{ errors.get('password') }}</BaseError>
        <RouterLink class="mt-1" :to="{ name: 'auth.password-recovery' }">
          Esqueci minha senha
        </RouterLink>
        <SubmitButton class="btn btn-primary w-100" type="submit" :loading="submiting">
          Entrar
        </SubmitButton>
      </form>
      <div class="d-flex flex-wrap align-items-end mt-5 gap-2">
        <span style="font-size: .9rem;">
          Ainda não administra seu delivery com a Rapideats?
        </span>
        <RouterLink :to="{ name: 'register' }">
          Começar agora
        </RouterLink>
      </div>
    </div>
  </TemplateLogin>
</template>

<script>
import TemplateLogin from './Components/TemplateLogin.vue'
import BaseInput from './Components/BaseInput.vue'
import SubmitButton from './Components/SubmitButton.vue'
import BaseButton from '@/components/BaseButton.vue'
import { mapActions } from 'pinia'
import { useUserStore } from '@/stores/user.js'
import { request } from '@/js/api.js'
import BaseError from '@/components/BaseError.vue'
import { freeTest } from '@/js/Links'
import useValidationErrors from '@/js/useValidationErrors'

export default {
  components: {
    TemplateLogin,
    SubmitButton,
    BaseInput,
    BaseButton,
    BaseError
  },
  data: () => {
    return {
      form: {
        email: null,
        password: null
      },
      errors: new useValidationErrors(),
      submiting: false,
      link: freeTest()
    }
  },
  methods: {
    ...mapActions(useUserStore, ['setToken', 'setUser', 'setMenus']),
    async onSubmit() {
      this.submiting = true

      try {
        const { data } = await request().post('auth/login', this.form)
        this.setToken(data.access_token)

        const response = await request().get('auth/me')
        this.setUser(response.data)

        this.$router.push({ name: 'stores.choose' })
      } catch (error) {
        this.errors.record(error.response.data.errors)
      }

      this.submiting = false
    }
  }
}
</script>
