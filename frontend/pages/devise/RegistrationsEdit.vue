<template lang="pug">
  v-app
    h2 Edit User
    ul.error-messages(v-if="errorMessages.length > 0")
      li(v-for="message in errorMessages") {{message}}

    form(class="edit_user" id="edit_user" action="/users" accept-charset="UTF-8" method="post")
      input(type="hidden" name="_method" value="put")
      input(type="hidden" name="authenticity_token" :value="formAuthenticityToken")
      div(class='field')
        label(for="user_email") Email
        br
        input(autofocus="autofocus" autocomplete="email" type="email" name="user[email]" id="user_email" :value="user.email")
      div(class='field')
        label(for="user_password") Password
        i leave blank if you dont want to change it
        br
        input(autocomplete="new-password" type="password" name="user[password]" id="user_password")
        br
        em(v-if="minimumPasswordLength") ({{minimumPasswordLength}} characters minimum)
      div(class='field')
        label(for="user_password_confirmation") Password confirmation
        br
        input(autocomplete="new-password" type="password" name="user[password_confirmation]" id="user_password_confirmation")
      div(class='field')
        label(for="user_current_password") Current password
        i we need your current password to confirm your changes
        br
        input(autocomplete="current-password" type="password" name="user[current_password]" id="user_current_password")
      div(class='actions')
        input(type="submit" name="commit" value="Update" data-disable-with="Update")
    h3 Cancel my account
    p Unhappy?
    form(class="button_to" method="post" action="/users")
      input(type="hidden" name="_method" value="delete")
      input(data-confirm="Are you sure?" type="submit" value="Cancel my account")
      input(type="hidden" name="authenticity_token" :value="formAuthenticityToken")
    a(href="javascript:history.back()") Back

</template>

<script>
export default {
  vuetify: new Vuetify({icons: {iconfont: 'mdi'}}),
  data () {
    return {
      currentUser: currentUser || {},
      user: railsParams.user || {email: currentUser.email},
      formAuthenticityToken: formAuthenticityToken,
      minimumPasswordLength: minimumPasswordLength,
      errorMessages: errorMessages
    };
  }
};

</script>

<style lang="scss" scoped>
#registrations-edit {

}
</style>
