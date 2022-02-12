<template lang="pug">
  v-app
    h2 Log in
    form(class="new_user" id="new_user" action="/users/sign_in" accept-charset="UTF-8" method="post")
      input(type="hidden" name="authenticity_token" :value="formAuthenticityToken")
      div(class='field')
        label(for="user_email") Email
        br
        input(autofocus="autofocus" autocomplete="email" type="email" value="" name="user[email]" id="user_email")
      div(class='field')
        label(for="user_password") Password
        br
        input(autocomplete="current-password" type="password" name="user[password]" id="user_password")
      div(class='actions')
        input(type="submit" name="commit" value="Log in" data-disable-with="Log in")
      a(href="/users/sign_up") Sign up

</template>

<script>
export default {
  vuetify: new Vuetify({icons: {iconfont: 'mdi'}}),
  data () {
    return {
      formAuthenticityToken: formAuthenticityToken,
    };
  }
};

</script>

<style lang="scss" scoped>
#sessions-new {

}
</style>
