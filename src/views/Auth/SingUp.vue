<template>
  <TemplateLogin>
    <div class="d-flex flex-column justify-content-center h-100 px-4">
      <h1>Cadastre-se</h1>
      <p>Crei sua conta grátis.</p>
      <form class="d-flex flex-column" novalidate @submit.prevent="onSubmit">
        <label for="nome">Nome</label>
        <input class="form-control" type="text" id="nome" v-model="form.name" />
        <BaseError>{{ errors.get('name') }}</BaseError>
        <label for="login-email">Email</label>
        <input class="form-control" id="login-email" type="email" v-model="form.email" />
        <BaseError>{{ errors.get('email') }}</BaseError>
        <label for="login-cellphone" class="mt-2">Celular</label>
        <input class="form-control"  v-maska data-maska="(##) #####-####" id="login-cellphone" type="tel" v-model="form.cellphone" />
        <BaseError>{{ errors.get('cellphone') }}</BaseError>
        <label for="login-password" class="mt-2">Senha</label>
        <input class="form-control" id="login-password" type="password" v-model="form.password" />
        <BaseError>{{ errors.get('password') }}</BaseError>
        <div class="mt-2">
          <small>
            This site is protected by reCAPTCHA and the Google
            <a href="https://policies.google.com/privacy">Privacy Policy</a> and
            <a href="https://policies.google.com/terms">Terms of Service</a> apply.
          </small>
        </div>
        <SubmitButton class="btn btn-primary w-100" type="submit" :loading="submiting">
          Criar minha conta
        </SubmitButton>
      </form>
      <div class="d-flex flex-wrap align-items-end mt-5 gap-2">
        <span style="font-size: .9rem;">
          Já possuí uma conta?
        </span>
        <RouterLink :to="{ name: 'auth.login' }">
          Login
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
        name: null,
        email: null,
        password: null,
        cellphone: null
      },
      errors: new useValidationErrors(),
      submiting: false,
    }
  },
  methods: {
    ...mapActions(useUserStore, ['setToken', 'setUser', 'setMenus']),
    async onSubmit() {
      try {
        this.submiting = true
        const token = await grecaptcha.execute(import.meta.env.VITE_RECAPTHCA_KEY, { action: 'submit' })
        const { data } = await request().post('sing-up', { ...this.form, recaptcha_token: token })

        this.setToken(data.token)
        this.setUser(data.user)

        this.$router.push({ name: 'stores.choose' })
      } catch (error) {
        this.errors.record(error.response.data.errors)
      }

      this.submiting = false
    }
  }
}
</script>
