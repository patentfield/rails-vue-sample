<template lang="pug">
  v-app
    h2 Sign up
    ul.error-messages(v-if="errorMessages.length > 0")
      li(v-for="message in errorMessages") {{message}}

    form(class="new_user" id="new_user" action="/users" accept-charset="UTF-8" method="post")
      input(type="hidden" name="authenticity_token" :value="formAuthenticityToken")
      div(class='field')
        label(for="user_email") Email
        br
        input(autofocus="autofocus" autocomplete="email" type="email" name="user[email]" id="user_email" :value="user.email")

      div(class='field')
        label(for="user_password") Password
        em(v-if="minimumPasswordLength") ({{minimumPasswordLength}} characters minimum)
        br
        input(autocomplete="new-password" type="password" name="user[password]" id="user_password")
      div(class='field')
        label(for="user_password_confirmation") Password confirmation
        br
        input(autocomplete="new-password" type="password" name="user[password_confirmation]" id="user_password_confirmation")
      div(class='actions')
        input(type="submit" name="commit" value="Sign up" data-disable-with="Sign up")
    a(href="/users/sign_in") Log in

</template>

<script>
export default {
  vuetify: new Vuetify({icons: {iconfont: 'mdi'}}),
  data () {
    return {
      user: railsParams.user || {},
      formAuthenticityToken: formAuthenticityToken,
      minimumPasswordLength: minimumPasswordLength,
      errorMessages: errorMessages
    };
  }
};

</script>

<style lang="scss" scoped>
#registrations-new {

}
</style>
